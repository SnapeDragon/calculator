class UnitModel {
  
  var Unit = ['Length', 'Area', 'Mass'];

  var lengthUnit = ['Inch', 'Centimeter', 'Foot', 'Meter', 'Kilometer', 'Mile'];
  var areaUnit = [
    'Square inch',
    'Square foot',
    'Square yard',
    'Square mile',
    'Square meter',
    'Square Kilometer',
    'Hectare',
    'Acre'
  ];
  var massUnit = ['Gram', 'Kilogram', 'Pound', 'Tonne', 'Quintal'];

  var conversion = {
    'Length': {
      01: 2.54,
      02: 0.0833,
      03: 0.0254,
      04: 0.0000254,
      05: 0.0000157828,
      10: 0.393701,
      12: 0.0328084,
      13: 0.01,
      14: 0.00001,
      15: 0.00000621371,
      20: 12.00,
      21: 30.48,
      23: 0.3048,
      24: 0.0003048,
      25: 0.000189394,
      30: 39.3701,
      31: 100.0,
      32: 3.28084,
      34: 0.001,
      35: 0.000621371,
      40: 39370.1,
      41: 100000.0,
      42: 3280.84,
      43: 1000.0,
      45: 0.621371,
      50: 63360.0,
      51: 160934.0,
      52: 5280.0,
      53: 1609.34,
      54: 1.60934,
    },
    'Area': {
      01: 0.00694444,
      02: 0.000771605,
      03: 0.000000000249097669,
      04: 0.00064516,
      05: 0.00000000064516,
      06: 0.000000064516,
      07: 0.00000015942,
      10: 144.0,
      12: 0.111111,
      13: 0.00000003587,
      14: 0.092903,
      15: 0.000000092903,
      16: 0.0000092903,
      17: 0.000022957,
      20: 1296.0,
      21: 9.0,
      23: 0.000000032283,
      24: 0.836127,
      25: 0.00000083613,
      26: 0.000083613,
      27: 0.000206612,
      30: 4014489600.0,
      31: 27878400.0,
      32: 3097600.0,
      34: 2589988.0,
      35: 2.58999,
      36: 258.999,
      37: 640.0,
      40: 1550.0,
      41: 10.7639,
      42: 1.19599,
      43: 0.0000003861,
      45: 0.000001,
      46: 0.0001,
      47: 0.000247105,
      50: 155003100.0,
      51: 10763910.0,
      52: 1195990.0,
      53: 0.00386102,
      54: 1000000.0,
      56: 100.0,
      57: 247.105,
      60: 15500000.0,
      61: 107639.0,
      62: 11959.9,
      63: 0.00386102,
      64: 10000.0,
      65: 0.01,
      67: 2.47105,
      70: 6273000.0,
      71: 43560.0,
      72: 4840.0,
      73: 0.0015625,
      74: 4046.86,
      75: 0.00404686,
      76: 0.404686,
    },
    'Mass': {
      01: 0.001,
      02: 0.00220462,
      03: 0.000001,
      04: 0.00001,

      10: 1000, // Kg to pound
      12: 2.20462,
      13: 0.001,
      14: 0.01,

      20: 453.592,
      21: 0.453592,
      23: 0.000453592,
      24: 0.00453592,

      30: 1000000,
      31: 1000,
      32: 2204.62,
      34: 10.0,

      40: 100000,
      41: 100,
      42: 220.462,
      43: 0.1,
    },
  };

// Function which return listset of particular Unit

  List getUnitList(String unitOf) {
//    if(unitOf == 'Length'){
//      return lengthUnit;
//    }
    switch (unitOf) {
      case 'Length':
        return lengthUnit;
      case 'Area':
        return areaUnit;
      case 'Mass':
        return massUnit;
    }
    return null;
  }

  double Multiplire({String unitOf, String unitA, String unitB}) {
    int key = getUnitList(unitOf).indexOf(unitA) * 10 +
        getUnitList(unitOf).indexOf(unitB);
    double multiplire = conversion[unitOf][key];

    if (multiplire == null && conversion[unitOf].containsKey(key)) {
      key = getUnitList(unitOf).indexOf(unitB) * 10 +
          getUnitList(unitOf).indexOf(unitA);
      multiplire = 1 / conversion[unitOf][key];
    }

    if (multiplire == null && unitA == unitB) {
      return 1;
    }
    return multiplire;
  }

  String hintBox({String unitOf, String unitA, String unitB}) {
    double multiplire = Multiplire(unitOf: unitOf, unitA: unitA, unitB: unitB);

    if (multiplire < 1)
      return "Divide with " + (1 / multiplire).toStringAsFixed(2);
    else
      return "Multiply with " + multiplire.toStringAsFixed(2);
  }

  double Calculate({String unitOf, String unitA, String unitB, double value}) {
    return value * Multiplire(unitOf: unitOf, unitA: unitA, unitB: unitB);
  }
}
