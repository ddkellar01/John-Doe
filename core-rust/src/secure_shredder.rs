use rand::RngCore;

pub fn overwrite_bytes(buffer: &mut [u8]) {
    let mut rng = rand::thread_rng();
    rng.fill_bytes(buffer);
}
