/// 좌표 구조체 선언
struct Coordinate {
    let x: Int
    let y: Int
}

let t = Int(readLine()!)!

/// [동, 남, 서, 북] 방향 정의
let dx = [1, 0, -1, 0]
let dy = [0, 1, 0, -1]

for _ in 0..<t {
    solution()
}

func solution() {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let m = input[0], n = input[1], k = input[2]
    var graph = [[Int]](repeating: [Int](repeating: 0, count: m), count: n)
    for _ in 0..<k {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let x = input[0], y = input[1]
        graph[y][x] = 1
    }
    
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: m), count: n)
    
    /// 그래프의 범위를 벗어나는지 알 수 있는 함수
    /// - Parameter coord: x, y 좌표
    /// - Returns: 범위를 벗어나지 않으면 false, 벗어나면 true
    func isVaildCoordinate(coord: Coordinate) -> Bool {
        return 0..<n ~= coord.y && 0..<m ~= coord.x
    }
    
    func dfs(coord: Coordinate) {
        visited[coord.y][coord.x] = true
        
        for i in 0..<4 {
            let ny = coord.y + dy[i]
            let nx = coord.x + dx[i]
            
            if isVaildCoordinate(coord: Coordinate(x: nx, y: ny)) && !visited[ny][nx] && graph[ny][nx] == 1 {
                visited[ny][nx] = true
                dfs(coord: Coordinate(x: nx, y: ny))
            }
        }
        
    }
    
    var answer = 0
    
    for y in 0..<n {
        for x in 0..<m {
            if !visited[y][x] && graph[y][x] == 1 {
                answer += 1
                dfs(coord: Coordinate(x: x, y: y))
            }
        }
    }
    
    print(answer)
}