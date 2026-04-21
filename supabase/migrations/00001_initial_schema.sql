-- SumiDay Initial Schema (v1.0)
-- Based on PRD v1.1

-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- Enum types
create type current_level as enum ('initiate', 'apprentice', 'practitioner', 'adept', 'sage');
create type tradition as enum ('stoic', 'zen', 'tao', 'analects');
create type path_status as enum ('active', 'coming_soon');
create type progress_status as enum ('active', 'completed', 'paused');
create type entitlement_type as enum ('subscription', 'path_buyout', 'intro');

-- 1. Profiles Table (extends auth.users)
create table profiles (
  id uuid references auth.users on delete cascade not null primary key,
  email text unique not null,
  display_name text,
  preferred_locale text default 'en',
  practice_time time default '07:00:00',
  level current_level default 'initiate',
  total_sessions_completed int default 0,
  current_streak int default 0,
  longest_streak int default 0,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 2. Paths Table
create table paths (
  id uuid default uuid_generate_v4() primary key,
  tradition tradition not null,
  title text not null,
  description text not null,
  duration_days int not null check (duration_days in (7, 30)),
  is_intro boolean default false,
  price_tier text not null, -- StoreKit product ID
  sort_order int not null,
  status path_status default 'active'
);

-- 3. Sessions Table
create table sessions (
  id uuid default uuid_generate_v4() primary key,
  path_id uuid references paths(id) on delete cascade not null,
  day_number int not null check (day_number between 1 and 30),
  passage_source text not null,
  passage_original text not null,
  passage_modern text not null,
  audio_url text,
  socratic_prompts jsonb not null,
  sort_order int not null,
  unique (path_id, day_number)
);

-- 4. User Path Progress
create table user_path_progress (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references profiles(id) on delete cascade not null,
  path_id uuid references paths(id) on delete cascade not null,
  current_day int default 1 not null,
  started_at timestamp with time zone default timezone('utc'::text, now()) not null,
  completed_at timestamp with time zone,
  replay_count int default 0 not null,
  status progress_status default 'active' not null,
  unique (user_id, path_id)
);

-- 5. Journal Entries
create table journal_entries (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references profiles(id) on delete cascade not null,
  session_id uuid references sessions(id) on delete cascade not null,
  user_path_progress_id uuid references user_path_progress(id) on delete cascade not null,
  user_reflection text not null,
  ai_response text not null,
  ai_citations jsonb not null,
  is_public boolean default false,
  replay_number int default 0 not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 6. Entitlements (RevenueCat sync)
create table entitlements (
  user_id uuid references profiles(id) on delete cascade not null,
  product_id text not null,
  type entitlement_type not null,
  is_active boolean default true,
  expires_at timestamp with time zone,
  purchased_at timestamp with time zone default timezone('utc'::text, now()) not null,
  primary key (user_id, product_id)
);

-- 7. AI Gateway Configuration (Admin only)
create table ai_config (
  id int primary key check (id = 1), -- Ensure only one config row
  active_provider text not null default 'claude', -- 'claude', 'openai', 'gemini'
  updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Row Level Security (RLS) Policies
alter table profiles enable row level security;
alter table user_path_progress enable row level security;
alter table journal_entries enable row level security;
alter table entitlements enable row level security;
alter table ai_config enable row level security;

-- Users can read and update their own profile
create policy "Users can view own profile" on profiles for select using (auth.uid() = id);
create policy "Users can update own profile" on profiles for update using (auth.uid() = id);

-- Users can view and update their own progress
create policy "Users can view own progress" on user_path_progress for select using (auth.uid() = user_id);
create policy "Users can update own progress" on user_path_progress for update using (auth.uid() = user_id);
create policy "Users can insert own progress" on user_path_progress for insert with check (auth.uid() = user_id);

-- Users can read and insert their own journal entries
create policy "Users can view own entries" on journal_entries for select using (auth.uid() = user_id);
create policy "Users can create own entries" on journal_entries for insert with check (auth.uid() = user_id);
create policy "Users can update own entries" on journal_entries for update using (auth.uid() = user_id);

-- Users can view their own entitlements
create policy "Users can view own entitlements" on entitlements for select using (auth.uid() = user_id);

-- Only service role (admin) can view or change ai_config (default behavior blocks public)
