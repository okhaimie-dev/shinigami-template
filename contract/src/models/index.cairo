#[derive(Copy, Drop, Serde)]
#[dojo::model]
pub struct Player {
    #[key]
    pub game_id: u128,
    #[key]
    pub address: felt252,
    pub rank: u8,
}
