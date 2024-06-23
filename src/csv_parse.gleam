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
    Ok(file) -> io.println(file)
    Error(e) -> describe_error(e) |> io.println
  }
  let list = gsv.to_lists(file_name)
  let _ = io.debug(list) 
  io.println("")
}
