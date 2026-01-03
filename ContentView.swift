import SwiftUI

struct ContentView: View {
    let model = YearModel(date: Date())
    
    // Grid columns
    let columns = Array(repeating: GridItem(.flexible(), spacing: 6), count: 20) // About 15-20 columns looks right for phone width
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    Button(action: {}) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(Color.gray.opacity(0.5))
                    }
                    Spacer()
                    Text(String(model.year))
                        .font(.custom("Palatino-Roman", size: 24)) // Serif font
                        .foregroundColor(.white)
                    Spacer()
                    // Spacer to balance the X button
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.clear)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                Spacer()
                
                // The Grid
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(12), spacing: 8), count: 18), spacing: 8) {
                    ForEach(0..<model.totalDays, id: \.self) { index in
                        Circle()
                            .fill(model.isDayPassed(dayIndex: index) ? Color(red: 0.5, green: 0.6, blue: 1.0) : Color.gray.opacity(0.3)) // Light Indigo vs Gray
                            .frame(width: 8, height: 8)
                    }
                }
                .padding()
                
                Spacer()
                
                // Footer
                HStack(spacing: 8) {
                    Text("\(model.daysLeft)d left")
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                    Text("·")
                        .foregroundColor(.gray)
                    Text(model.formattedPercentage)
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }
                .padding(.bottom, 20)
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
