import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

struct PasswordStruct: Codable {
  var letter: String
  var text: String
  var min: Int
  var max: Int
}

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

private func getData() ->  [PasswordStruct] {
  do {
    let localData = readLocalFile(forName: "02.input")!
    return try JSONDecoder().decode([PasswordStruct].self, from: localData)
  } catch {
    print(error)
  }
  return []
}

private func getMinMaxPasswords(data: [PasswordStruct]) -> Int? {
  let filteredPasswords = data.filter { password in 
    let count = password.text.filter { $0 == Character(password.letter) }.count
    return password.min...password.max ~= count
  }
  return filteredPasswords.count
}

private func getPositionPasswords(data: [PasswordStruct]) -> Int? {
  let filteredPasswords = data.filter { password in
    let text = password.text 
    let hasFirst = text[password.min - 1] == Character(password.letter)
    let hasSecond = text[password.max - 1] == Character(password.letter)
    return hasFirst != hasSecond
  }
  return filteredPasswords.count
}

print(getMinMaxPasswords(data: getData()) as Any);
print(getPositionPasswords(data: getData()) as Any);
