use std::fs::File;
use std::io::{Read, Seek, SeekFrom};

//const BOOTIMG_MAGIC: &[u8; 8] = b"ANDROID!";
const BOOT_MAGIC_SIZE: usize = 8;
const BOOT_NAME_SIZE: usize = 16;
const BOOT_ARGS_SIZE: usize = 512;

#[repr(C)]
#[derive(Debug)]
pub struct BootImgHdr {
    pub magic: [u8; BOOT_MAGIC_SIZE],

    pub kernel_size: u32,
    pub kernel_addr: u32,

    pub ramdisk_size: u32,
    pub ramdisk_addr: u32,

    pub second_size: u32,
    pub second_addr: u32,

    pub tags_addr: u32,
    pub page_size: u32,

    pub unused: [u32; 2],

    pub name: [u8; BOOT_NAME_SIZE],

    pub cmdline: [u8; BOOT_ARGS_SIZE],

    pub id: [u32; 8],
}


impl BootImgHdr {
    pub fn read(file: &mut File) -> Self {
        let mut buffer = [0u8; std::mem::size_of::<BootImgHdr>()];

        file.seek(SeekFrom::Start(0))
            .expect("Cannot seek from start 0");
        file.read_exact(&mut buffer)
            .expect("Cannot read into buffer");

        let hdr: BootImgHdr = unsafe { std::ptr::read(buffer.as_ptr() as *const _) };

        return hdr;
    }
}
