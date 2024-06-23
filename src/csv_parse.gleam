import argv
import gleam/io
import gsv
import simplifile.{describe_error, read}

pub fn main() {
  case argv.load().arguments {
    [file_name] -> to_list(file_name)
    _ -> io.println("args")
  }
}

fn to_list(file_name: String) -> Nil {
  let read_file = read(file_name)

  case read_file {
    Ok(file) -> {
      let assert Ok(records) = gsv.to_lists(file)
      let _ = io.debug(records)
      io.println("")
    }
    Error(e) -> describe_error(e) |> io.println
  }
}