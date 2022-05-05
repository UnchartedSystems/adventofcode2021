use std::fs;

fn count_increases(span: usize)-> usize {

    let scans: String = fs::read_to_string("i1.txt").expect("oh shit");
    let parses: Vec<usize> = scans.lines().map(|x| x.parse::<usize>().unwrap()).collect();
    let mut count: usize = 0;
    let mut index: usize = 0;

    while index < parses.len() - span {
        if parses[index..index + span].iter().sum::<usize>() < parses[index + 1..index + span + 1].iter().sum::<usize>() {
            count += 1;
        } else {
        }
        index += 1;
    }
    return count;
}


fn main() {
    println!("{}", count_increases(1));
    println!("{}", count_increases(3));
}
