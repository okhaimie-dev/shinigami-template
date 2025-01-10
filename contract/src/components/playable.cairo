#[starknet::component]
mod PlayableComponent {
    // Core imports
    use core::debug::PrintTrait;

    // Dojo imports
    use dojo::world::WorldStorage;

    // Starknet imports
    use starknet::ContractAddress;
    use starknet::info::{get_caller_address};

    // Internal imports
    use shinigami_template::store::{Store, StoreTrait};
    use shinigami_template::models::player::{Player, PlayerTrait};

    // Errors
    mod errors {}

    // Storage
    #[storage]
    struct Storage {}

    // Events
    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {}

    #[generate_trait]
    impl InternalImpl<TState, +HasComponent<TState>> of InternalTrait<TState> {
        fn spawn(ref self: ComponentState<TState>, world: WorldStorage, game_id: u128) {
            // [Setup] Datastore
            let mut store: Store = StoreTrait::new(world);

            // [Effect] Create player
            let player_address: felt252 = get_caller_address().into();
            let mut player = PlayerTrait::new(game_id, player_address);

            // [Effect] Set player
            store.set_player(player);
        }
    }
}
