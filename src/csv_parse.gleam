import argv
import gleam/io
import gleam/list
import gsv.{Unix,Windows}
import simplifile.{describe_error, read}

pub fn main() {
  case argv.load().arguments {
    [file_name] -> to_list(file_name)
    _ -> io.println("no file name argument")
  }
}

fn to_list(file_name: String) -> Nil {
  let read_file = read(file_name)

  case read_file {
    Ok(file) -> {
      let assert Ok(records) = gsv.to_lists(file)
      let ten_records = records |> list.take(3)
      let _ = io.debug(ten_records)
      io.println("")
    }
    Error(e) -> describe_error(e) |> io.println
  }
}