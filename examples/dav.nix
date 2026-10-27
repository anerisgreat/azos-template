# Two-way sync of CalDAV task lists (vdirsyncer + todoman).
{...}: {
  azos.dav.enable = true;

  accounts.calendar.accounts.nextcloud = {
    remote = {
      type = "caldav";
      url = "https://cloud.example.com/remote.php/dav/";
      userName = "user";
      passwordCommand = ["azos-password-get" "cloud.example.com"];
    };
    vdirsyncer = {
      enable = true;
      collections = ["from a"];
      itemTypes = ["VTODO"];
    };
  };
}
