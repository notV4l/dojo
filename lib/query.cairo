use dict::DictFeltToTrait;

#[derive(Copy, Drop)]
struct Entity {}

struct Or<T> {}

struct Option<T> {}

struct Component<T> {}

struct Query<T> {
    data: DictFeltTo::<T>, 
}

trait QueryTrait<T> {
    fn new() -> Query::<T>;
    fn insert(ref self: Query::<T>, key: felt, value: T);
    fn get(ref self: Query::<T>, index: felt) -> T;
}

impl QueryImpl<T> of QueryTrait::<T> {
    #[inline(always)]
    fn new() -> Query::<T> {
        Query { data: DictFeltToTrait::new(),  }
    }

    fn insert(ref self: Query::<T>, key: felt, value: T) {
        let mut data = self.data;
        data.insert(key, value);
        self = Query {data};
    }

    fn get(ref self: Query::<T>, index: felt) -> T {
        let mut data = self.data;
        data.get(index)
    }
}

impl QueryDrop of Drop::<Query::<felt>>;
impl DictFeltToDrop of Drop::<DictFeltTo::<felt>>;

#[test]
fn test_query() {
    let mut query = QueryTrait::<felt>::new();
    query.insert(1, 1);
}