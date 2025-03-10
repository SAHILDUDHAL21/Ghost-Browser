```mermaid
classDiagram
    class User {
        int userID
        String username
        String email
        String password
        login() void
        logout() void
        manageProfile() void
    }

    class Profile {
        int profileID
        String preference
        List<Bookmark> bookmarks
        List<History> history
        savePreference() void
        addBookmark(Bookmark) void
        clearHistory() void
    }

    class Browser {
        int tabID
        String URL
        String tabTitle
        openURL(String) void
        reload() void
        closeTab(int) void
        navigateBack() void
        navigateForward() void
    }

    class Bookmark {
        int bookmarkID
        String URL
        String title
        addBookmark() void
        removeBookmark(int) void
        editBookmark(int, String) void
    }

    class History {
        int historyID
        String URL
        DateTime timestamp
        addHistory(String) void
        deleteHistory(int) void
        getHistory() List<History>
    }

    class Setting {
        int settingID
        String name
        String value
        updateSetting(String, String) void
        resetSetting() void
        getSetting() String
    }

    %% Relationships
    User --> Profile : has
    Profile --> Bookmark : contains
    Profile --> History : contains
    Browser --> Bookmark : manages
    Browser --> History : tracks