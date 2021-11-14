Aplikacja nie bazuje na żadnym przykładzie. Jest to projekt w pełni autorski.

Aplikacja umożliwia odpalanie plików muzycznych przchowywanych lokalnie na telefonie.

Przed przystąpieniem do pisania aplikacji posiadałem zerową wiedzę w zakresie
tworzenia aplikacji mobilnych, darta oraz fluttera. Do chwili ibecnej nauczyłęm się darta oraz fluttera
w poziomie pozwalającym na pisanie podstawowych aplikacji. Zaznajomiłem się z wielowątkowością oraz biblioteką widgetów.
W projekcie użyłem kilka bibliotek widocznych w pliku pubspec.yaml:

  shared_preferences: ^2.0.5 - możliwośc zapisywania danych w pamięci twardej urządzenia (swego rodzaju lokalna baza danych)

  flutter_blue: ^0.8.0 - metody pozwalające na zarządzanie połączeniem bluetooth

  flutter_audio_query: ^0.3.5+6 - wyszukuje pliki audio na telefonie oraz udostenia szereg metod pozwalających
  na szybkie przeszukiwanie plików np. po artystach

  assets_audio_player: ^3.0.3+2 - zarządzanie aktualnie odpalonym plikiem audio, playlisty itp. Cała logika tej biblioteki
  znajduje sie w pliku AssetsAudioPlayerService.dart


