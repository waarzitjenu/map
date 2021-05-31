export interface ConfigFileProperties {
  MAPBOX_ACCESS_TOKEN: string;
  LOCATION_API_ENDPOINT: string;
}

export interface ConfigWindow extends Window {
  $config: ConfigFileProperties;
}
