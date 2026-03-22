# MIT License
#
# Copyright (c) 2023-present Poing Studios
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

class_name NativeOverlayAd
extends MobileSingletonPlugin

static var _plugin = _get_plugin("PoingGodotAdMobNativeOverlayAd")

var ad_listener := AdListener.new()
var _uid: int

func _init(uid: int) -> void:
	self._uid = uid
	if _plugin:
		safe_connect(_plugin, "on_native_overlay_ad_clicked", _on_ad_clicked)
		safe_connect(_plugin, "on_native_overlay_ad_closed", _on_ad_closed)
		safe_connect(_plugin, "on_native_overlay_ad_impression", _on_ad_impression)
		safe_connect(_plugin, "on_native_overlay_ad_opened", _on_ad_opened)

func render_template(style: NativeTemplateStyle, ad_position: AdPosition) -> void:
	if _plugin:
		if ad_position.value == AdPosition.Values.CUSTOM:
			_plugin.render_template_custom_position(_uid, style.convert_to_dictionary(), ad_position.offset.x, ad_position.offset.y)
		else:
			_plugin.render_template(_uid, style.convert_to_dictionary(), ad_position.value)

func destroy() -> void:
	if _plugin:
		_plugin.destroy(_uid)

func hide() -> void:
	if _plugin:
		_plugin.hide(_uid)

func show() -> void:
	if _plugin:
		_plugin.show(_uid)

func set_position(ad_position: AdPosition) -> void:
	if _plugin:
		if ad_position.value == AdPosition.Values.CUSTOM:
			_plugin.update_custom_position(_uid, ad_position.offset.x, ad_position.offset.y)
		else:
			_plugin.update_position(_uid, ad_position.value)

func get_width() -> int:
	if _plugin:
		return _plugin.get_width(_uid)
	return -1
	
func get_height() -> int:
	if _plugin:
		return _plugin.get_height(_uid)
	return -1
	
func get_width_in_pixels() -> int:
	if _plugin:
		return _plugin.get_width_in_pixels(_uid)
	return -1
	
func get_height_in_pixels() -> int:
	if _plugin:
		return _plugin.get_height_in_pixels(_uid)
	return -1

func _on_ad_clicked(uid: int) -> void:
	if uid == self._uid and ad_listener.on_ad_clicked.is_valid():
		ad_listener.on_ad_clicked.call()

func _on_ad_closed(uid: int) -> void:
	if uid == self._uid and ad_listener.on_ad_closed.is_valid():
		ad_listener.on_ad_closed.call()

func _on_ad_impression(uid: int) -> void:
	if uid == self._uid and ad_listener.on_ad_impression.is_valid():
		ad_listener.on_ad_impression.call()

func _on_ad_opened(uid: int) -> void:
	if uid == self._uid and ad_listener.on_ad_opened.is_valid():
		ad_listener.on_ad_opened.call()
