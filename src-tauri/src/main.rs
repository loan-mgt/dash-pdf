use serde::Deserialize;

// Prevents additional console window on Windows in release, DO NOT REMOVE!!
#[cfg_attr(not(debug_assertions), windows_subsystem = "windows")]

// Learn more about Tauri commands at https://tauri.app/v1/guides/features/command
#[tauri::command]
fn greet(name: &str) -> String {
    format!("Hello, {}! You've been greeted from Rust!", name)
}

#[derive(Deserialize)]
struct FileData {
    name: String,
    content: String,
}

#[tauri::command]
fn compress(file_data: FileData) -> Result<String, String> {
    // No need to decode the base64 content, just return it as it is
    Ok(file_data.content)
}

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![greet])
        .invoke_handler(tauri::generate_handler![compress])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
