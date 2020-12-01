import Foundation

private func readLocalFile(forName name: String) -> Data? {
  do {
    if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
      let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
        return jsonData
      }
  } catch {
    print(error)
  }
  return nil
}

private func getData() ->  [Int] {
  do {
    let localData = readLocalFile(forName: "01.input")!
    return try JSONDecoder().decode([Int].self, from: localData)
  } catch {
    print(error)
  }
  return []
}

private func getSum(value: Int, data: [Int], count: Int = 2) -> Int? {
  for index in 0..<data.count {
    let item = data[index]
    let sub = data.suffix(from: index + 1)
    let acc = count > 2 ? getSum(value: value - data[index], data: Array(sub), count: count - 1) : sub.first(where: { $0 == (value - data[index] ) })
    if acc != nil { return item * acc! }
  }
  return nil
}

print(getSum(value: 2020, data: getData().sorted()) as Any);
print(getSum(value: 2020, data: getData().sorted(), count: 3) as Any);
