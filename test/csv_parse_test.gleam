import gleeunit
import gleeunit/should
import gleam/io
import gleam/list

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  1
  |> should.equal(1)
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
    [_, ..] -> Interview("other", "other", [])
  }

  // Interview("a", "一次", ["1さん", "2さん"])
}

pub fn recursive_int(items: List(Int)) -> Int {
  case items {
    [] -> 0
    [x, ..xs] -> x + recursive_int(xs)
  }
}

pub fn list_summary_test() {

  let data1 = [1, 2, 3, 4, 5]

  recursive_int(data1)
  |> io.debug
  

  let data = [
        Interview("a", "一次", ["1さん"]),
        Interview("a", "一次", ["2さん"]),
  ]

  // list.map(data, fn(x) {
  //   case x {
  //     [candidate_name, step, interviewers] -> Interview(candidate_name, step, [interviewers])
  //     _ -> Interview("other", "other", [])
  //   }
  // })
  // |> io.debug

  // let data2 = ["a", "一次", "1さん"]

  // let result = case data {
  //   [["a", test1, ..],_] -> test1
  //   _ -> "other"
  // }

  // let data3 = #("a", #("一次", ["1さん", "2さん"]))
// 

  io.debug(1 == 1 && 4 < 3)
  let data4 = Interview("a", "一次", ["1さん", "2さん"])
// 
  // io.debug(data4)
  interview_merge(data)
  |> should.equal(data4)

}