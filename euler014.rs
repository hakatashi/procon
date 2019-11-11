use std::collections::HashMap;
use std::vec::Vec;

fn read<T: std::str::FromStr>() -> T {
  let mut s = String::new();
  std::io::stdin().read_line(&mut s).ok();
  s.trim().parse().ok().unwrap()
}

fn main() {
  let mut dp = HashMap::new();
  dp.insert(1, 1);
  let mut minimum = 2_u64;
  while minimum <= 5000000 {
    while dp.contains_key(&minimum) {
      minimum += 1;
    }
    let mut value = minimum;
    let mut history = Vec::new();
    while !dp.contains_key(&value) {
      history.push(value);
      if value % 2 == 0 {
        value = value / 2;
      } else {
        value = value * 3 + 1;
      }
    }
    history.reverse();
    for (i, v) in history.iter().enumerate() {
      dp.insert(*v, dp.get(&value).unwrap() + i + 1);
    }
  }
  let mut max_steps = 0;
  let mut cursor = 0;
  for i in 1..5000001 {
    let steps = *dp.get(&i).unwrap();
    if max_steps <= steps {
      max_steps = steps;
      cursor = i as usize;
    }
    dp.insert(i, cursor);
  }
  let t = read::<i32>();
  for _i in 0..t {
    let n = read::<u64>();
    println!("{}", dp.get(&n).unwrap().to_string());
  }
}