# MIT License

# Copyright (c) 2026-present Poing Studios

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

static func manage_visibility(editor_plugin: EditorPlugin = null) -> void:
	var is_csharp_project := false
	var is_mono_version := ClassDB.class_exists("CSharpScript")
	
	var files := DirAccess.get_files_at("res://")
	for file in files:
		if file.get_extension() == "csproj":
			is_csharp_project = true
			break
	
	var csharp_gdignore_path := "res://addons/admob/csharp/.gdignore"
	var should_hide := not is_mono_version or not is_csharp_project
	
	if not should_hide:
		if FileAccess.file_exists(csharp_gdignore_path):
			var error := DirAccess.remove_absolute(csharp_gdignore_path)
			if error == OK:
				print("AdMob: C# project detected, .gdignore removed.")
				_refresh_filesystem(editor_plugin, csharp_gdignore_path)
			else:
				print("AdMob: Failed to remove .gdignore: ", error)
	else:
		if not FileAccess.file_exists(csharp_gdignore_path):
			var file := FileAccess.open(csharp_gdignore_path, FileAccess.WRITE)
			if file:
				file.store_string("")
				file.close()
				print("AdMob: .gdignore created to hide C# folder.")
				_refresh_filesystem(editor_plugin, csharp_gdignore_path)

static func _refresh_filesystem(editor_plugin: EditorPlugin = null, file_path: String = "") -> void:
	if not editor_plugin:
		return
		
	var filesystem := editor_plugin.get_editor_interface().get_resource_filesystem()
	if not filesystem:
		return
		
	if file_path != "":
		filesystem.update_file(file_path)
	
	# Delaying the scan slightly or using call_deferred helps with initial project load conflicts
	filesystem.call_deferred("scan")
