#!MC 1410
$!VarSet |MFBD| = './'
$!VarSet |FILEN| = '6'
$!PICK SETMOUSEMODE
  MOUSEMODE = SELECT
$!PAGE NAME = 'Untitled'
$!PAGECONTROL CREATE
$!PICK SETMOUSEMODE
  MOUSEMODE = SELECT
$!OPENLAYOUT  "layout.lay"
$!PRINTSETUP PALETTE = COLOR
$!EXPORTSETUP IMAGEWIDTH = 1067
$!EXPORTSETUP EXPORTFNAME = '|MFBD|/|FILEN|.png'
$!EXPORT
  EXPORTREGION = CURRENTFRAME
$!RemoveVar |FILEN|
$!RemoveVar |MFBD|
