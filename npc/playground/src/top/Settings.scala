package top

object DefaultSettings {
  def apply() = Map(
    // "MemMapBase" -> 0x0000000000000000L,
    // "MemMapRegionBits" -> 0,
    // "MMIOBase" -> 0x0000000040000000L,
    // "MMIOSize" -> 0x0000000040000000L,
    "ResetVector" -> 0x8000_0000L,
    // "NrExtIntr" -> 1,

    // "HasL2cache" -> true,
    // "HasPrefetch" -> true,
    // "EnableMultiIssue" -> false,
    // "EnableOutOfOrderExec" -> false,
    // "HasDTLB" -> true,
    // "HasITLB" -> true,
    // "HasDcache" -> true,
    // "HasIcache" -> true,
    // "MmodeOnly" -> false,
    // "IsRV32" -> false,

    // "FPGAPlatform" -> false,
    // "EnableILA" -> true,
    // "EnableDebug" -> true,
    // "EnableRVC" -> true
  )
}

object Settings {
  var settings: Map[String, AnyVal] = DefaultSettings()
  def get(field: String) = {
    settings(field).asInstanceOf[Boolean]
  }
  def getLong(field: String) = {
    settings(field).asInstanceOf[Long]
  }
  def getInt(field: String) = {
    settings(field).asInstanceOf[Int]
  }
}

