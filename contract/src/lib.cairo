mod constants;
mod store;

mod types {
    mod task;
    mod trophy;
}

mod models {
    mod index;
    mod player;
}

mod components {
    mod playable;
}

mod systems {
    mod actions;
}

mod elements {
    mod tasks {
        mod collecting;
        mod interface;
    }
    mod trophies {
        mod collector;
        mod interface;
    }
}

mod helpers {}

#[cfg(test)]
mod tests {
    mod setup;
}
