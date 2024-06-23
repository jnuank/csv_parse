import gleam/io
import gleam/result
import argv
import gsv.{Unix}


pub fn main() {
  case argv.load().arguments {
    [file_name] -> to_list(file_name)

    _ -> io.println("args")
  }
}


fn to_list(file_name: String) -> Nil {
  let list = gsv.to_lists(file_name) 

  io.debug(list)
  io.println("")

}