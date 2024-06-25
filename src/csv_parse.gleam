import argv
import gleam/dict
import gleam/io
import gleam/list
import gleam/result
import gsv
import simplifile.{describe_error, read}

pub fn main() {
  case argv.load().arguments {
    [file_name] -> to_list(file_name)
    _ -> io.println("no file name argument")
  }
}

fn to_list(file_name: String) -> Nil {
  let read_file = read(file_name)

  let func = fn(x, i) {
    case i {
      0 | 12 | 19 -> x
      _ -> ""
    }
  }

  case read_file {
    Ok(file) -> {
      let assert Ok(records) = gsv.to_lists(file)

      let data =
        records
        |> list.drop(1)
        |> list.map(fn(xs) {
          xs |> list.index_map(func) |> list.filter(fn(x) { x != "" })
        })

      data
      |> list.map(fn(xs) {
        case xs {
          [x, y, z] -> dict.new() |> dict.insert([x, y], [z])
          _ -> dict.new()
        }
      })
      |> list.reduce(fn(acc, x) {
        dict.combine(acc, x, fn(a, b) { list.append(a, b) })
      })
      |> result.unwrap(dict.from_list([]))
      |> io.debug

      io.println("")
    }
    Error(e) -> describe_error(e) |> io.println
  }
}
