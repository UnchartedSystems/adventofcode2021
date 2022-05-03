fn count_increases(nums: [u32; 10])-> i32 {
    let mut count: i32 = 0;
    let mut index: usize = 0;

    while index < nums.len() - 1 {
        if nums[index] < nums[(index + 1)] {
            count += 1;
        }
        index += 1;
    }
    return count;
}


static scans: [u32; 10] = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263];

fn main() {
    println!("{}", count_increases(scans));
}
