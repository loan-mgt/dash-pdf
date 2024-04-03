use serde::Deserialize;
use std::fs;
use tauri::api::path::download_dir;

// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#[cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

#[tauri::command]
fn greet(name: String) -> String {
    format!("Hello, {}! You've been greeted from Rust!", name)
}

#[derive(Deserialize)]
struct FileData {
    name: String,
    path: String, // File path instead of content
}

#[tauri::command]
fn compress(file_data: FileData) -> Result<(), String> {
    let file_content = fs::read(&file_data.path)
        .map_err(|e| format!("Failed to read file {}: {}", &file_data.path, e))?;

    // Directly use the Option returned by download_dir()
    let final_dir = download_dir().ok_or_else(|| format!("Failed to get download directory"))?;

    // Unwrap the Option to get the PathBuf and then call join
    let target_path = final_dir.join(&file_data.name);

    fs::write(&target_path, &file_content)
        .map_err(|e| format!("Failed to write file {}: {}", target_path.display(), e))?;

    println!("File copied to {}", target_path.display());
    Ok(())
}



fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![greet])
        .invoke_handler(tauri::generate_handler![compress])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
