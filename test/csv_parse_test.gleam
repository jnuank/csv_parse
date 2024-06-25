import gleeunit
import gleeunit/should
import gleam/io
import gleam/list
import gleam/set


pub fn main() {
  gleeunit.main()
}

pub type Interview { 
  Interview(candidate_name: String, step: String, interviewers: List(String))
}

pub fn interview_merge(interview: List(Interview) ) -> Interview {

  case interview {
    [x, ..xs] -> {
      let next = list.first(xs)
      case next {
        Ok(y) if x.candidate_name == y.candidate_name && x.step == y.step -> Interview(x.candidate_name, x.step, list.append(x.interviewers , y.interviewers))
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
 
pub fn interview_merge2(interviews: List(Interview), total: List(Interview)) -> List(Interview) {
  case interviews {
    // [x, y, ..xs] if x.candidate_name == y.candidate_name && x.step == y.step -> {
    //   let merged = list.append([Interview(x.candidate_name, x.step, list.append(x.interviewers, y.interviewers))], total)
    //   interview_merge2(list.append(merged, xs), merged)
    // }
    [x, y, ..xs] -> {
      let merged = list.append( total, [Interview(x.candidate_name, x.step, list.append(x.interviewers, y.interviewers))])
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

  let expected = [Interview("a", "一次", ["1さん", "2さん"]), Interview("b", "一次", ["3さん", "4さん", "5さん"])]

  interview_merge2(data, [])
  |> should.equal(expected)
}

pub fn set_test() {
  set.new()
  |> set.insert(["b", "c"])
  |> set.insert(["a"])
  |> set.contains(["b", "c"])
  |> io.debug
}