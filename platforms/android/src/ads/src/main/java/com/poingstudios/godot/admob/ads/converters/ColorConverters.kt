// MIT License
//
// Copyright (c) 2023-present Poing Studios
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
package com.poingstudios.godot.admob.ads.converters

import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.util.Log

fun String.toAndroidColor(): Int {
    if (this.isEmpty()) return Color.TRANSPARENT
    
    val hex = if (this.startsWith("#")) this else "#$this"
    
    return try {
        Color.parseColor(hex)
    } catch (e: Exception) {
        Log.e("PoingAdMob", "Failed to parse color: $hex. Falling back to Transparent.")
        Color.TRANSPARENT
    }
}

fun String.toColorDrawable(): ColorDrawable {
    return ColorDrawable(this.toAndroidColor())
}
