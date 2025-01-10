use achievement::types::task::{Task as ArcadeTask};
use shinigami_template::elements::trophies;

// Constants

pub const TROPHY_COUNT: u8 = 3;

// Types

#[derive(Copy, Drop)]
enum Trophy {
    None,
    CollectorI,
    CollectorII,
    CollectorIII,
}

#[generate_trait]
impl TrophyImpl of TrophyTrait {
    #[inline]
    fn level(self: Trophy) -> u8 {
        match self {
            Trophy::None => 0,
            Trophy::CollectorI => 0,
            Trophy::CollectorII => 1,
            Trophy::CollectorIII => 2,
        }
    }

    #[inline]
    fn identifier(self: Trophy) -> felt252 {
        let level = self.level();
        match self {
            Trophy::None => 0,
            Trophy::CollectorI => trophies::collector::Collector::identifier(level),
            Trophy::CollectorII => trophies::collector::Collector::identifier(level),
            Trophy::CollectorIII => trophies::collector::Collector::identifier(level),
        }
    }

    #[inline]
    fn hidden(self: Trophy) -> bool {
        let level = self.level();
        match self {
            Trophy::None => true,
            Trophy::CollectorI => trophies::collector::Collector::hidden(level),
            Trophy::CollectorII => trophies::collector::Collector::hidden(level),
            Trophy::CollectorIII => trophies::collector::Collector::hidden(level),
        }
    }

    #[inline]
    fn index(self: Trophy) -> u8 {
        let level = self.level();
        match self {
            Trophy::None => 0,
            Trophy::CollectorI => trophies::collector::Collector::index(level),
            Trophy::CollectorII => trophies::collector::Collector::index(level),
            Trophy::CollectorIII => trophies::collector::Collector::index(level),
        }
    }

    #[inline]
    fn points(self: Trophy) -> u16 {
        let level = self.level();
        match self {
            Trophy::None => 0,
            Trophy::CollectorI => trophies::collector::Collector::points(level),
            Trophy::CollectorII => trophies::collector::Collector::points(level),
            Trophy::CollectorIII => trophies::collector::Collector::points(level),
        }
    }

    #[inline]
    fn start(self: Trophy) -> u64 {
        // TODO: Update start time if you want to create ephemeral trophies
        0
    }

    #[inline]
    fn end(self: Trophy) -> u64 {
        // TODO: Update end time if you want to create ephemeral trophies
        // Note: End time must be greater than start time
        0
    }

    #[inline]
    fn group(self: Trophy) -> felt252 {
        match self {
            Trophy::None => 0,
            Trophy::CollectorI => trophies::collector::Collector::group(),
            Trophy::CollectorII => trophies::collector::Collector::group(),
            Trophy::CollectorIII => trophies::collector::Collector::group(),
        }
    }

    #[inline]
    fn icon(self: Trophy) -> felt252 {
        let level = self.level();
        match self {
            Trophy::None => 0,
            Trophy::CollectorI => trophies::collector::Collector::icon(level),
            Trophy::CollectorII => trophies::collector::Collector::icon(level),
            Trophy::CollectorIII => trophies::collector::Collector::icon(level),
        }
    }

    #[inline]
    fn title(self: Trophy) -> felt252 {
        let level = self.level();
        match self {
            Trophy::None => 0,
            Trophy::CollectorI => trophies::collector::Collector::title(level),
            Trophy::CollectorII => trophies::collector::Collector::title(level),
            Trophy::CollectorIII => trophies::collector::Collector::title(level),
        }
    }

    #[inline]
    fn description(self: Trophy) -> ByteArray {
        let level = self.level();
        match self {
            Trophy::None => "",
            Trophy::CollectorI => trophies::collector::Collector::description(level),
            Trophy::CollectorII => trophies::collector::Collector::description(level),
            Trophy::CollectorIII => trophies::collector::Collector::description(level),
        }
    }

    #[inline]
    fn count(self: Trophy, level: u8) -> u32 {
        match self {
            Trophy::None => 0,
            Trophy::CollectorI => trophies::collector::Collector::count(level),
            Trophy::CollectorII => trophies::collector::Collector::count(level),
            Trophy::CollectorIII => trophies::collector::Collector::count(level),
        }
    }

    #[inline]
    fn tasks(self: Trophy) -> Span<ArcadeTask> {
        let level = self.level();
        match self {
            Trophy::None => [].span(),
            Trophy::CollectorI => trophies::collector::Collector::tasks(level),
            Trophy::CollectorII => trophies::collector::Collector::tasks(level),
            Trophy::CollectorIII => trophies::collector::Collector::tasks(level),
        }
    }

    #[inline]
    fn data(self: Trophy) -> ByteArray {
        ""
    }
}

impl IntoTrophyU8 of core::Into<Trophy, u8> {
    #[inline]
    fn into(self: Trophy) -> u8 {
        match self {
            Trophy::None => 0,
            Trophy::CollectorI => 1,
            Trophy::CollectorII => 2,
            Trophy::CollectorIII => 3,
        }
    }
}

impl IntoU8Trophy of core::Into<u8, Trophy> {
    #[inline]
    fn into(self: u8) -> Trophy {
        let card: felt252 = self.into();
        match card {
            0 => Trophy::None,
            1 => Trophy::CollectorI,
            2 => Trophy::CollectorII,
            3 => Trophy::CollectorIII,
            _ => Trophy::None,
        }
    }
}

impl TrophyPrint of core::debug::PrintTrait<Trophy> {
    #[inline]
    fn print(self: Trophy) {
        self.identifier().print();
    }
}
