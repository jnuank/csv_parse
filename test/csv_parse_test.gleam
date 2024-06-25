import gleam/dict
import gleam/io
import gleam/list
import gleam/set.{type Set}
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub type Interview {
  Interview(candidate_name: String, step: String, interviewers: List(String))
}

pub type Interview2 {
  // Setはユニークな値のコレクション
  // Listの中のInterviewのCandiateたちがユニークであるかどうか
  Interview2(candidate: Set(List(String)), interviewers: List(String))
}

// pub fn contains(self: Interview2, other: Interview2) -> Bool {
//   self.candidate 
//   |> set.contains(other.candidate)

// }

pub fn interview_merge(interview: List(Interview)) -> Interview {
  case interview {
    [x, ..xs] -> {
      let next = list.first(xs)
      case next {
        Ok(y) if x.candidate_name == y.candidate_name && x.step == y.step ->
          Interview(
            x.candidate_name,
            x.step,
            list.append(x.interviewers, y.interviewers),
          )
        Ok(_) -> x
        Error(_) -> x
      }
    }
    [] -> Interview("other", "other", [])
  }
}

// pub fn interview_merge2(interview: List(Interview) ) -> List(Interview) {
// 
// case interview {
// [x, ..xs] -> {
// let next = list.first(xs)
// case next {
// Ok(y) if x.candidate_name == y.candidate_name && x.step == y.step ->  interview_merge2(list.append([Interview(x.candidate_name, x.step, list.append(x.interviewers , y.interviewers))], xs))
// Ok(_) -> [x]
// Error(_) -> [x]
// }
// }
// [] -> [Interview("other", "other", [])]
// }
// }

pub fn interview_merge2(
  interviews: List(Interview),
  total: List(Interview),
) -> List(Interview) {
  case interviews {
    // [x, y, ..xs] if x.candidate_name == y.candidate_name && x.step == y.step -> {
    //   let merged = list.append([Interview(x.candidate_name, x.step, list.append(x.interviewers, y.interviewers))], total)
    //   interview_merge2(list.append(merged, xs), merged)
    // }
    [x, y, ..xs] -> {
      let merged =
        list.append(total, [
          Interview(
            x.candidate_name,
            x.step,
            list.append(x.interviewers, y.interviewers),
          ),
        ])
      io.debug(merged)
      io.debug(list.append(merged, xs))
      io.debug(list.append(merged, list.append(merged, xs)))
    }
    //  interview_merge2(list.append(merged, xs), merged)}
    [] -> [Interview("other", "other", [])]
    [_] -> [Interview("other", "other", [])]
  }
  total
}

//   case interviews {
//     [x, y, ..xs] if x.candidate_name == y.candidate_name && x.step == y.step -> interview_merge(list.append([Interview(x.candidate_name, x.step, list.append(x.interviewers, y.interviewers))], xs))
//     [x, y, ..xs] -> interview_merge(xs)
//     [x, y] if x.candidate_name == y.candidate_name && x.step == y.step -> interview_merge([Interview(x.candidate_name, x.step, list.append(x.interviewers, y.interviewers))])
//     [x, y] -> interview_merge([y])
//     [] -> Interview("other", "other", [])
//     [_] -> Interview("other", "other", [])
//   }
// }

pub fn recursive_int(items: List(Int)) -> Int {
  case items {
    [] -> 0
    [x, ..xs] -> x + recursive_int(xs)
  }
}

pub fn list_summary_test() {
  let data = [
    Interview("a", "一次", ["1さん"]),
    Interview("a", "一次", ["2さん"]),
  ]

  let data4 = Interview("a", "一次", ["1さん", "2さん"])

  interview_merge(data)
  |> should.equal(data4)
}

pub fn list3_summary_test() {
  let data = [
    Interview("b", "一次", ["3さん"]),
    Interview("b", "一次", ["4さん"]),
    Interview("b", "一次", ["5さん"]),
    Interview("a", "一次", ["1さん"]),
    Interview("a", "一次", ["2さん"]),
  ]

  let expected = [
    Interview("a", "一次", ["1さん", "2さん"]),
    Interview("b", "一次", ["3さん", "4さん", "5さん"]),
  ]
  // interview_merge2(data, [])
  // |> should.equal(expected)
}

pub fn list4_summary_test() {
  //   let data = dict.from_list([ 
  //         #([ "a", "一次", ],["1さん"]),
  //         #([ "a", "一次", ],["2さん"]),
  //         #([ "b", "一次", ],["3さん"]),
  //         #([ "b", "一次", ],["4さん"]),
  //         #([ "b", "一次", ],["5さん"]),
  //  ])
  let data = dict.from_list([#(["a", "一次"], ["1さん"])])
  let data2 = dict.from_list([#(["a", "一次"], ["2さん"])])

  let data3 = dict.from_list([#(["b", "一次"], ["3さん"])])
  let data4 = dict.from_list([#(["b", "一次"], ["4さん"])])
  let data5 = dict.from_list([#(["b", "一次"], ["5さん"])])

  let expected =
    dict.from_list([
      #(["a", "一次"], ["1さん", "2さん"]),
      #(["b", "一次"], ["3さん", "4さん", "5さん"]),
    ])

  let func = fn(a, b) { list.append(a, b) }
  data
  |> dict.combine(data2, func)
  |> dict.combine(data3, func)
  |> dict.combine(data4, func)
  |> dict.combine(data5, func)
  |> should.equal(expected)
}

pub fn interview_test() {
  let expected =
    Interview2(set.new() |> set.insert(["a", "一次"]), ["1さん", "2さん"])

  Interview2(set.new() |> set.insert(["a", "一次"]), ["1さん", "2さん"])
  |> should.equal(expected)
}

pub fn interview2_test() {
  let actual =
    Interview2(set.new() |> set.insert(["a", "一次"]), ["1さん", "2さん"])
  let compaire =
    Interview2(set.new() |> set.insert(["a", "一次"]), ["3さん", "4さん"])

  // contains(actual, compaire)
  // contains(actual, compaire)
  True
  |> should.equal(True)
}

pub fn dict_test() {
  let expected = [
    Interview("a", "一次", ["1さん", "2さん"]),
    Interview("b", "一次", ["3さん", "4さん", "5さん"]),
  ]

  // dict.from_list([#(["a", "b"], ["1さん", "2さん"]), #(["a,","b"], ["3さん", "4さん", "5さん"])])
  // |> io.debug()

  let a =
    dict.from_list([
      #(["a", "一次"], ["1さん", "2さん"]),
      #(["b", "一次"], ["1さん", "2さん"]),
    ])
  let b =
    dict.from_list([
      #(["a", "一次"], ["1さん", "2さん"]),
      #(["a", "二次"], ["1さん", "2さん"]),
    ])
  // dict.combine(a, b, fn(one, other) { list.append( one, other) })
  // |> io.debug
  // -> from_list([#("a", 2), #("b", 1), #("c", 3)])

  // dict.new()
  // |> dict.insert("a", 1)
  // |> io.debug

  
}
