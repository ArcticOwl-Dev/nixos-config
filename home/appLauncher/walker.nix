{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    inputs.walker.homeManagerModules.default
  ];

  # Ensure walker binary is in PATH
  # home.packages = [ 
  #   inputs.walker.packages.${pkgs.stdenv.hostPlatform.system}.walker
  # ];

  programs.walker = {
    enable = true;
    runAsService = true;

    # Window resizes with list: small when empty, grows when you type (natural height)
    themes.compact = {
      style = builtins.readFile "${inputs.walker}/resources/themes/default/style.css"
        + ''

/* Margin from top when anchored to top (Walker has no shell.margin_top config) */
.box-wrapper {
  margin-top: 24px;
}
'';
      layouts = {
        "layout" = ''
          <?xml version="1.0" encoding="UTF-8"?>
          <interface>
            <requires lib="gtk" version="4.0"></requires>
            <object class="GtkWindow" id="Window">
              <style><class name="window"/></style>
              <property name="resizable">true</property>
              <property name="title">Walker</property>
              <child>
                <object class="GtkBox" id="BoxWrapper">
                  <style><class name="box-wrapper"/></style>
                  <property name="overflow">hidden</property>
                  <property name="orientation">horizontal</property>
                  <property name="valign">center</property>
                  <property name="halign">center</property>
                  <property name="width-request">520</property>
                  <child>
                    <object class="GtkBox" id="Box">
                      <style><class name="box"/></style>
                      <property name="orientation">vertical</property>
                      <property name="hexpand-set">true</property>
                      <property name="hexpand">true</property>
                      <property name="spacing">10</property>
                      <child>
                        <object class="GtkBox" id="SearchContainer">
                          <style><class name="search-container"/></style>
                          <property name="overflow">hidden</property>
                          <property name="orientation">horizontal</property>
                          <property name="halign">fill</property>
                          <property name="hexpand-set">true</property>
                          <property name="hexpand">true</property>
                          <child>
                            <object class="GtkEntry" id="Input">
                              <style><class name="input"/></style>
                              <property name="halign">fill</property>
                              <property name="hexpand-set">true</property>
                              <property name="hexpand">true</property>
                            </object>
                          </child>
                        </object>
                      </child>
                      <child>
                        <object class="GtkBox" id="ContentContainer">
                          <style><class name="content-container"/></style>
                          <property name="orientation">horizontal</property>
                          <property name="spacing">10</property>
                          <child>
                            <object class="GtkLabel" id="ElephantHint">
                              <style><class name="elephant-hint"/></style>
                              <property name="label">Waiting for elephant...</property>
                              <property name="hexpand">true</property>
                              <property name="vexpand">true</property>
                              <property name="visible">false</property>
                              <property name="valign">0.5</property>
                            </object>
                          </child>
                          <child>
                            <object class="GtkLabel" id="Placeholder">
                              <style><class name="placeholder"/></style>
                              <property name="label">No Results</property>
                              <property name="hexpand">true</property>
                              <property name="vexpand">true</property>
                              <property name="valign">0.5</property>
                            </object>
                          </child>
                          <child>
                            <object class="GtkScrolledWindow" id="Scroll">
                              <style><class name="scroll"/></style>
                              <property name="can_focus">false</property>
                              <property name="overlay-scrolling">true</property>
                              <property name="hexpand">true</property>
                              <property name="vexpand">false</property>
                              <property name="max-content-width">450</property>
                              <property name="min-content-width">450</property>
                              <property name="max-content-height">400</property>
                              <property name="min-content-height">0</property>
                              <property name="propagate-natural-height">true</property>
                              <property name="propagate-natural-width">true</property>
                              <property name="hscrollbar-policy">automatic</property>
                              <property name="vscrollbar-policy">automatic</property>
                              <child>
                                <object class="GtkGridView" id="List">
                                  <style><class name="list"/></style>
                                  <property name="max_columns">1</property>
                                  <property name="min_columns">1</property>
                                  <property name="can_focus">false</property>
                                </object>
                              </child>
                            </object>
                          </child>
                          <child>
                            <object class="GtkBox" id="Preview">
                              <style><class name="preview"/></style>
                            </object>
                          </child>
                        </object>
                      </child>
                      <child>
                        <object class="GtkBox" id="Keybinds">
                          <property name="hexpand">true</property>
                          <property name="margin-top">10</property>
                          <style><class name="keybinds"/></style>
                          <child>
                            <object class="GtkBox" id="GlobalKeybinds">
                              <property name="spacing">10</property>
                              <style><class name="global-keybinds"/></style>
                            </object>
                          </child>
                          <child>
                            <object class="GtkBox" id="ItemKeybinds">
                              <property name="hexpand">true</property>
                              <property name="halign">end</property>
                              <property name="spacing">10</property>
                              <style><class name="item-keybinds"/></style>
                            </object>
                          </child>
                        </object>
                      </child>
                      <child>
                        <object class="GtkLabel" id="Error">
                          <style><class name="error"/></style>
                          <property name="xalign">0</property>
                          <property name="visible">false</property>
                        </object>
                      </child>
                    </object>
                  </child>
                </object>
              </child>
            </object>
          </interface>
        '';
      };
    };

    # Configuration options
    config = {
      theme = "compact";
      placeholders.default = {
        input = "Search";
        list = "";  # empty list placeholder when no results
      };
      # No providers when query is empty → list stays empty on start
      providers.empty = [];
      providers.prefixes = [
        { provider = "websearch"; prefix = "+"; }
        { provider = "providerlist"; prefix = "_"; }
      ];
      keybinds.quick_activate = ["F1" "F2" "F3"];
      hide_action_hints = true;
    };
  };
}