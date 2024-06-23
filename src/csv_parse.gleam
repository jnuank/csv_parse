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
    Ok(file) -> to_list_print(file)
    Error(e) -> describe_error(e) |> io.println
  }
  io.println("")
}

fn to_list_print(csv_str: String) -> Nil {
  let assert Ok(records) = gsv.to_lists(csv_str)
  let _ = io.debug(records)
  io.println("")
}