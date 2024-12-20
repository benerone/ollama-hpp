@echo off
REM Run this script to generate a single-header include for Ollama.hpp that combines the header-only libraries in ./include

REM Remove the includes to other libraries in ollama.hpp
powershell -Command "(Get-Content include\ollama.hpp) | Select-Object -Skip 46 -First 7 | Select-Object -Skip 1 | Select-Object -Skip 7 -First 8 | Select-Object -Skip 1 | Set-Content no_includes_ollama.hpp"

REM Combine the headers into one file
(
    type include\json.hpp
    echo.
    echo.
    type include\httplib.h
    echo.
    echo.
    type include\Base64.h
    echo.
    echo.
    type no_includes_ollama.hpp
) > singleheader\ollama.hpp

REM Clean up
del no_includes_ollama.hpp

echo Header-only library created in singleheader\ollama.hpp