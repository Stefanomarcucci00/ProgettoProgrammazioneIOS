import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// Made by Alessandro Pieragostini, Matteo Sonaglioni & Stefano Marcucci
/* Questa classe permette al ChipController per le tipologie di cibo e a quello
per le tipologie dei prodotti all'interno del menu di essere inizializzate
e di poter cambiare index essendo ascoltate dall'applicazione */

// ChipController per le tipologie di cibo dei ristoranti
class ChipController extends GetxController {
  var _selectedChip = 0.obs;
  get selectedChip => this._selectedChip.value;
  set selectedChip(index) => this._selectedChip.value = index;
}

// ChipController per le tipologie dei prodotti all'interno dei menu
class ChipControllerMenu extends GetxController {
  var _selectedChip = 0.obs;
  get selectedChip => this._selectedChip.value;
  set selectedChip(index) => this._selectedChip.value = index;
}