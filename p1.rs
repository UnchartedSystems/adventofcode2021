use std::fs;

fn count_increases()-> usize {

    let scans: String = fs::read_to_string("i1.txt").expect("oh shit");
    let parses: Vec<usize> = scans.lines().map(|x| x.parse::<usize>().unwrap()).collect();
    let mut count: usize = 0;
    let mut count2: usize = 0;
    let mut index: usize = 0;

    if 123 < 23 {
        println!("num true");
    } else {
        println!("num false");
    }

    if "123" < "23" {
        println!("str true");
    } else {
        println!("str false");
    }

    while index < parses.len() - 1 {
        if parses[index] < parses[index + 1] {
            count += 1;
        } else {
        count2 += 1;
        }
        index += 1;
    }
    println!("{}", count);
    println!("{}", count2);
    return count;
}


fn main() {
    println!("{}", count_increases());
}
