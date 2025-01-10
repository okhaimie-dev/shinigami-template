use dojo::world::IWorldDispatcher;

// define the interface
#[starknet::interface]
trait IActions<TState> {
    fn spawn(ref self: TState, game_id: u128);
}

// dojo decorator
#[dojo::contract]
pub mod actions {
    use super::{IActions};
    use starknet::{ContractAddress};

    use shinigami_template::components::playable::PlayableComponent;
    use shinigami_template::models::player::Player;
    use shinigami_template::types::task::{Task, TaskTrait};
    use shinigami_template::types::trophy::{Trophy, TrophyTrait, TROPHY_COUNT};
    use shinigami_template::constants::DEFAULT_NS;

    use achievement::components::achievable::AchievableComponent;

    use dojo::world::WorldStorage;

    component!(path: PlayableComponent, storage: playable, event: PlayableEvent);
    impl PlayableInternalImpl = PlayableComponent::InternalImpl<ContractState>;
    component!(path: AchievableComponent, storage: achievable, event: AchievableEvent);
    impl AchievableInternalImpl = AchievableComponent::InternalImpl<ContractState>;

    #[storage]
    struct Storage {
        #[substorage(v0)]
        playable: PlayableComponent::Storage,
        #[substorage(v0)]
        achievable: AchievableComponent::Storage,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        PlayableEvent: PlayableComponent::Event,
        #[flat]
        AchievableEvent: AchievableComponent::Event,
    }

    fn dojo_init(self: @ContractState) {
        // [Event] Emit all Trophy events
        let world = self.world(@DEFAULT_NS());
        let mut trophy_id: u8 = TROPHY_COUNT;
        while trophy_id > 0 {
            let trophy: Trophy = trophy_id.into();
            self
                .achievable
                .create(
                    world,
                    id: trophy.identifier(),
                    hidden: trophy.hidden(),
                    index: trophy.index(),
                    points: trophy.points(),
                    start: trophy.start(),
                    end: trophy.end(),
                    group: trophy.group(),
                    icon: trophy.icon(),
                    title: trophy.title(),
                    description: trophy.description(),
                    tasks: trophy.tasks(),
                    data: trophy.data(),
                );
            trophy_id -= 1;
        }
    }

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {
        fn spawn(ref self: ContractState, game_id: u128) {
            let world = self.world_storage();
            self.playable.spawn(world, game_id);
        }
    }

    #[generate_trait]
    impl Private of PrivateTrait {
        /// Use the default namespace "dojo_starter". This function is handy since the ByteArray
        /// can't be const.
        fn world_storage(self: @ContractState) -> WorldStorage {
            self.world(@DEFAULT_NS())
        }
    }
}
