import SwiftUI

struct OnboardingView: View {
    @State private var currentStep = 0
    @State private var selectedPracticeTime: Date? = nil
    
    var body: some View {
        ZStack {
            Color.washi.ignoresSafeArea()
            
            Group {
                switch currentStep {
                case 0:
                    BrandMomentView {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            currentStep = 1
                        }
                    }
                case 1:
                    PathSelectionView {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            currentStep = 2
                        }
                    }
                    .transition(.asymmetric(insertion: .opacity.animation(.easeInOut(duration: 0.4).delay(0.2)), removal: .opacity))
                case 2:
                    SetPracticeTimeView { time in
                        selectedPracticeTime = time
                        withAnimation(.easeInOut(duration: 0.4)) {
                            currentStep = 3
                        }
                    }
                    .transition(.asymmetric(insertion: .opacity.animation(.easeInOut(duration: 0.4).delay(0.2)), removal: .opacity))
                case 3:
                    PurchaseIntroView()
                        .transition(.asymmetric(insertion: .opacity.animation(.easeInOut(duration: 0.4).delay(0.2)), removal: .opacity))
                default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
