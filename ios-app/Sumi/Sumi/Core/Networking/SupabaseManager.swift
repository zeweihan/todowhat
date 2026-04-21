import Foundation
import Supabase

/// 核心的 Supabase 管理器，负责维护一个稳定的连接单例。
class SupabaseManager {
    static let shared = SupabaseManager()
    
    let client: SupabaseClient
    
    private init() {
        // 在此处读取你的环境变量，或者直接拿 Secrets.swift 里的数据
        // 注意：如果是生产环境，建议采用更安全的混淆存取法，MVP阶段这样最快。
        self.client = SupabaseClient(
            supabaseURL: URL(string: Secrets.supabaseURL)!,
            supabaseKey: Secrets.supabaseAnonKey
        )
    }
}
