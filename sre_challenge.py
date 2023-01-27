import re

class sre_challenge:
    input_arr = []
    out_arr = []
    invalid_input_message = 'Please follow input Constraints: 0 < N < 100'
    def __init__(self):
        self.no_of_elements = input()
        if (self.no_of_elements and self.no_of_elements.isnumeric()):
            self.no_of_elements = int(self.no_of_elements)
            if (self.no_of_elements > 0 and self.no_of_elements < 100):
                for i in range(0, self.no_of_elements):
                    element = str(input())
                    self.input_arr.append(element)
    def pre_validate_cc(self):
        if(not self.input_arr):
            print(self.invalid_input_message)

    def validate_cc(self):
        try:
            for each_ele in self.input_arr:
                # print('checking {0}'.format(each_ele))
                x = re.findall("^[456][0-9]{3}-?[0-9]{4}-?[0-9]{4}-?[0-9]{4}$", each_ele)
                if x:
                    y = re.sub('-', '', each_ele)
                    z = re.findall("^.*([0]{4,}|[1]{4,}|[2]{4,}|[3]{4,}|[4]{4,}|[5]{4,}|[6]{4,}|[7]{4,}|[8]{4,}|[9]{4,}|[4]{4,}[4]{4,}).*$", y)
                    if z:
                        self.out_arr.append('Invalid')
                    else:
                        self.out_arr.append('Valid')
                else:
                    self.out_arr.append('Invalid')
        except Exception as e:
            print(e)

    def post_validate_cc(self):
        for each_ele in self.out_arr:
            print(each_ele)
    '''
    def run_program():
        try:
            input_check = take_user_input()
        except Exception as e:
            print(e)
            run_program()

        # got the inputs straightened
        validate_each_input()
        share_results()
    '''

input_arr = []
out_arr = []

s1 = sre_challenge()
s1.pre_validate_cc()
s1.validate_cc()
s1.post_validate_cc()
