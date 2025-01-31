------------------------------------------------------------------------------
--                                                                          --
--                         GNAT COMPILER COMPONENTS                         --
--                                                                          --
--                             B A C K _ E N D                              --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--          Copyright (C) 1992-2025, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License  distributed with GNAT; see file COPYING3.  If not, go to --
-- http://www.gnu.org/licenses for a complete copy of the license.          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

--  Call the back end with all the information needed

--  Note: there are multiple bodies/variants of this package, so do not
--  modify this spec without coordination.

package Back_End is

   type Back_End_Mode_Type is (
      Generate_Object,
      --  Full back end operation with object file generation

      Declarations_Only,
      --  Partial back end operation with no object file generation. In this
      --  mode the only useful action performed by gigi is to process all
      --  declarations issuing any error messages (in particular those to
      --  do with rep clauses), and to back annotate representation info.

      Skip);
      --  Back end call is skipped (syntax only, or errors found)

   pragma Convention (C, Back_End_Mode_Type);
   for Back_End_Mode_Type use (0, 1, 2);

   procedure Call_Back_End (Mode : Back_End_Mode_Type);
   --  Call back end, i.e. make call to driver traversing the tree and
   --  outputting code. This call is made with all tables locked. The back
   --  end is responsible for unlocking any tables it may need to change,
   --  and locking them again before returning.

   procedure Scan_Compiler_Arguments;
   --  Acquires command-line parameters passed to the compiler and processes
   --  them. Calls Scan_Front_End_Switches for any front-end switches found.
   --
   --  The processing of arguments is private to the back end, since the way
   --  of acquiring the arguments as well as the set of allowable back end
   --  switches is different depending on the particular back end being used.
   --
   --  Any processed switches that influence the result of a compilation must
   --  be added to the Compilation_Arguments table.
   --
   --  This routine is expected to set the following to True if necessary (the
   --  default for all of these in Opt is False).
   --
   --    Opt.Disable_FE_Inline
   --    Opt.Suppress_Control_Float_Optimizations
   --    Opt.Generate_SCO
   --    Opt.Generate_SCO_Instance_Table
   --    Opt.JSON_Output
   --    Opt.Stack_Checking_Enabled
   --    Opt.No_Stdinc
   --    Opt.No_Stdlib

   procedure Gen_Or_Update_Object_File;
   --  Is used to generate the object file (if generated directly by gnat1), or
   --  update it if it has already been generated by the call to Call_Back_End,
   --  so that its timestamp is updated by the call.
   --
   --  This is a no-op with the gcc back-end (the object file is generated by
   --  the assembler afterwards), but is needed for back-ends that directly
   --  generate the final object file so that the object file's timestamp is
   --  correct when compared with the corresponding ali file by gnatmake.

end Back_End;
