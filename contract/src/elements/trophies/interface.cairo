use achievement::types::task::{Task as BushidoTask};
use shinigami_template::types::task::{Task, TaskTrait};

trait TrophyTrait {
    fn identifier(level: u8) -> felt252;
    fn hidden(level: u8) -> bool;
    fn index(level: u8) -> u8;
    fn points(level: u8) -> u16;
    fn group() -> felt252;
    fn icon(level: u8) -> felt252;
    fn title(level: u8) -> felt252;
    fn description(level: u8) -> ByteArray;
    fn count(level: u8) -> u32;
    fn tasks(level: u8) -> Span<BushidoTask>;
}