#include "include/v8.h"
#include "libplatform/libplatform.h"

int main(int argc, char *argv[])
{
    // Initialize V8
    v8::V8::InitializeICUDefaultLocation(argv[0]);
    v8::V8::InitializeExternalStartupDataFromFile(argv[0]);
    std::unique_ptr<v8::Platform>
        platform = v8::platform::NewDefaultPlatform();
    v8::V8::InitializePlatform(platform.get());
    v8::V8::SetFlagsFromCommandLine(&argc, argv, true);
    v8::V8::Initialize();
}