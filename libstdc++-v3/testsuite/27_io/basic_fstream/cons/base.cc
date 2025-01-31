// Copyright (C) 2015-2025 Free Software Foundation, Inc.
//
// This file is part of the GNU ISO C++ Library.  This library is free
// software; you can redistribute it and/or modify it under the
// terms of the GNU General Public License as published by the
// Free Software Foundation; either version 3, or (at your option)
// any later version.

// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License along
// with this library; see the file COPYING3.  If not see
// <http://www.gnu.org/licenses/>.

// { dg-options "-O0" }
// { dg-do link { target c++11 } }

#include <fstream>
#include <string>

using namespace std;

string s;

template<typename T> struct F : T { F() : T(s) { } };

int main()
{
  F<fstream>  fee;
  F<ifstream> fi;
  F<ofstream> fo;
#ifdef _GLIBCXX_USE_WCHAR_T
  F<wfstream> fum;
  F<wifstream> fiw;
  F<wofstream> fow;
#endif
}
