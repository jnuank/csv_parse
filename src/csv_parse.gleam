import gleam/io
import gleam/result
import argv
import gsv.{Unix}
import simplifile.{read, describe_error}

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
  io.debug(list)
  io.println("")

}