echo off

if NOT DEFINED VCINSTALLDIR (
    if exist "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" (
        call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x86_amd64
        echo "USING VISUAL STUDIO 17"
    )
)

if NOT DEFINED VCINSTALLDIR (
    if exist "C:\Program Files (x86)\Microsoft Visual Studio 15.0\VC\vcvarsall.bat" (
        call "C:\Program Files (x86)\Microsoft Visual Studio 15.0\VC\vcvarsall.bat" amd64
        echo "USING VISUAL STUDIO 15"
    )
)

if NOT DEFINED VCINSTALLDIR (
    if exist "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" (
        call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64
        echo "USING VISUAL STUDIO 14"
    )
)

if NOT DEFINED VCINSTALLDIR (
    if exist "C:\Program Files (x86)\Microsoft Visual Studio 13.0\VC\vcvarsall.bat" (
        call "C:\Program Files (x86)\Microsoft Visual Studio 13.0\VC\vcvarsall.bat" amd64
        echo "USING VISUAL STUDIO 13"
    )
)

if NOT DEFINED VCINSTALLDIR (
    if exist "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" (
        call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" amd64
        echo "USING VISUAL STUDIO 12"
    )
)

echo "Using " %VCINSTALLDIR%

if NOT DEFINED VCINSTALLDIR (
    echo "No compatible visual studio found! run vcvarsall.bat first!"
)

python --version 2>NUL
if errorlevel 1 goto errorNoPython
set TIMEIT=python %~dp0/timeit.py
goto hasPython
:errorNoPython
set TIMEIT
:hasPython

mkdir build

%TIMEIT% cl.exe /O2 /D_CRT_SECURE_NO_WARNINGS /nologo /D_HAS_EXCEPTIONS=0 /EHsc /W4 /wd4611 /Isrc test/test_params.cpp test/main.cpp /link /out:.\build\test_params.exe
%TIMEIT% cl.exe /O2 /D_CRT_SECURE_NO_WARNINGS /nologo /D_HAS_EXCEPTIONS=0 /EHsc /W4 /wd4611 /Isrc test/test_typed_test.cpp test/main.cpp /link /out:.\build\test_typed_test.exe
%TIMEIT% cl.exe /O2 /D_CRT_SECURE_NO_WARNINGS /nologo /D_HAS_EXCEPTIONS=0 /EHsc /W4 /wd4611 /Isrc test/test_expect.cpp test/main.cpp /link /out:.\build\test_expect.exe
%TIMEIT% cl.exe /O2 /D_CRT_SECURE_NO_WARNINGS /nologo /D_HAS_EXCEPTIONS=0 /EHsc /W4 /wd4611 /Isrc test/test_death.cpp test/main.cpp /link /out:.\build\test_death.exe
%TIMEIT% cl.exe /O2 /D_CRT_SECURE_NO_WARNINGS /nologo /D_HAS_EXCEPTIONS=0 /EHsc /W4 /wd4611 /Isrc test/test_empty.cpp test/main.cpp /link /out:.\build\test_empty.exe
%TIMEIT% cl.exe /O2 /D_CRT_SECURE_NO_WARNINGS /nologo /D_HAS_EXCEPTIONS=0 /EHsc /W4 /wd4611 /Isrc test/test_array.cpp test/main.cpp /link /out:.\build\test_array.exe
%TIMEIT% cl.exe /O2 /D_CRT_SECURE_NO_WARNINGS /nologo /D_HAS_EXCEPTIONS=0 /EHsc /W4 /wd4611 /Isrc test/doctest/test_doctest.cpp /link /out:.\build\test_doctest.exe

del *.obj

