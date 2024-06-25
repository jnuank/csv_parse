import argv
import gleam/io
import gleam/list
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
      // 0 | 5 | 12 | 13 | 20 -> x
      0 | 12 | 20 -> x
      _ -> ""
    }
  }

  case read_file {
    Ok(file) -> {
      let assert Ok(records) = gsv.to_lists(file)

        records
        // |> list.take(20)
        |> list.map(fn(xs) {
          xs |> list.index_map(func) |> list.filter(fn(x) { x != "" })
        })
        |> io.debug
      io.println("")
    }
    Error(e) -> describe_error(e) |> io.println
  }
}
