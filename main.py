from kivy.app import App
from kivy.uix.label import Label
from kivy.uix.boxlayout import BoxLayout


class MainApp(App):
    def build(self):
        layout = BoxLayout(orientation='vertical')
        label = Label(text="Hello, Kivy!",
                      font_size='30sp',
                      size_hint=(.5, .5),
                      pos_hint={'center_x': .5, 'center_y': .5})
        layout.add_widget(label)
        return layout


if __name__ == '__main__':
    MainApp().run()
