import gleam/dict
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn list4_summary_test() {
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
