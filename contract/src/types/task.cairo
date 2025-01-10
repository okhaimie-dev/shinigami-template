// External imports
use achievement::types::task::{Task as ArcadeTask, TaskTrait as ArcadeTaskTrait};

// Internal imports
use shinigami_template::elements::tasks;

// Types
#[derive(Copy, Drop)]
enum Task {
    None,
    Collecting,
}

// Implementations
#[generate_trait]
impl TaskImpl of TaskTrait {
    #[inline]
    fn identifier(self: Task, level: u8) -> felt252 {
        match self {
            Task::None => 0,
            Task::Collecting => tasks::collecting::Collecting::identifier(level),
        }
    }

    #[inline]
    fn description(self: Task, count: u32) -> ByteArray {
        match self {
            Task::None => "",
            Task::Collecting => tasks::collecting::Collecting::description(count),
        }
    }

    #[inline]
    fn tasks(self: Task, level: u8, count: u32, total: u32) -> Span<ArcadeTask> {
        let task_id: felt252 = self.identifier(level);
        let description: ByteArray = self.description(count);
        array![ArcadeTaskTrait::new(task_id, total, description)].span()
    }
}

impl IntoTaskU8 of core::Into<Task, u8> {
    #[inline]
    fn into(self: Task) -> u8 {
        match self {
            Task::None => 0,
            Task::Collecting => 1,
        }
    }
}

impl IntoU8Task of core::Into<u8, Task> {
    #[inline]
    fn into(self: u8) -> Task {
        let card: felt252 = self.into();
        match card {
            0 => Task::None,
            1 => Task::Collecting,
            _ => Task::None,
        }
    }
}
