//! Store struct and component management methods.
use dojo::world::WorldStorage;
use dojo::model::ModelStorage;
use dojo::event::EventStorage;

// Models imports
use shinigami_template::models::player::Player;

// Structs
#[derive(Copy, Drop)]
struct Store {
    world: WorldStorage,
}

// Implementations
#[generate_trait]
impl StoreImpl of StoreTrait {
    #[inline]
    fn new(world: WorldStorage) -> Store {
        Store { world: world }
    }

    #[inline]
    fn set_player(ref self: Store, player: Player) {
        self.world.write_model(@player);
    }

    #[inline]
    fn get_player(self: Store, game_id: u128, address: felt252) -> Player {
        self.world.read_model((game_id, address))
    }
}
