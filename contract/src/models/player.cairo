// Core imports
use core::debug::PrintTrait;

// Inernal imports
use shinigami_template::models::index::Player;

mod errors {}

#[generate_trait]
impl PlayerImpl of PlayerTrait {
    #[inline]
    fn new(game_id: u128, address: felt252) -> Player {
        Player { game_id, address, rank: 0 }
    }
}

#[generate_trait]
impl PlayerAssert of AssertTrait {}

#[cfg(test)]
mod tests {
    // Local imports
    use super::{Player, PlayerTrait};

    #[test]
    fn test_player_new() {}
}
