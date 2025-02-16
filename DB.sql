PGDMP      5    
            |            courseStore    16.2    16.2 9    @           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            A           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            B           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            C           1262    16840    courseStore    DATABASE     �   CREATE DATABASE "courseStore" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "courseStore";
                postgres    false            �            1255    16973 A   управление_продажами_и_поставками()    FUNCTION     <  CREATE FUNCTION public."управление_продажами_и_поставками"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Уменьшаем количество товара в таблице Поставка
    UPDATE Поставка
    SET Количество = Количество - 1
    WHERE ID_товара = NEW.ID_товара;

    -- Увеличиваем количество продаж у работника в таблице Информация_о_работнике
    UPDATE Информация_о_работнике
    SET Количество_продаж = Количество_продаж + 1
    WHERE ID_работника = NEW.ID_продавца AND EXTRACT(MONTH FROM NEW.Дата_продажи) = EXTRACT(MONTH FROM CURRENT_DATE);

    RETURN NEW;
END;
$$;
 Z   DROP FUNCTION public."управление_продажами_и_поставками"();
       public          postgres    false            �            1259    25244 1   информация_о_работнике_id_seq    SEQUENCE     �   CREATE SEQUENCE public."информация_о_работнике_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 J   DROP SEQUENCE public."информация_о_работнике_id_seq";
       public          postgres    false            �            1259    16967 *   Информация_о_работнике    TABLE       CREATE TABLE public."Информация_о_работнике" (
    "id_работника" integer DEFAULT nextval('public."информация_о_работнике_id_seq"'::regclass) NOT NULL,
    "Количество_продаж" integer NOT NULL,
    "Количество_часов" integer NOT NULL,
    "Заработная_плата" numeric(10,2) GENERATED ALWAYS AS ((("Количество_часов" * 200) + ("Количество_продаж" * 30))) STORED NOT NULL,
    "Дата" date NOT NULL
);
 @   DROP TABLE public."Информация_о_работнике";
       public         heap    postgres    false    234            �            1259    25234    покупатель_id_seq    SEQUENCE     �   CREATE SEQUENCE public."покупатель_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public."покупатель_id_seq";
       public          postgres    false            �            1259    16919    Покупатель    TABLE       CREATE TABLE public."Покупатель" (
    "id_покупателя" integer DEFAULT nextval('public."покупатель_id_seq"'::regclass) NOT NULL,
    "Имя" character varying(50),
    "Возраст" integer,
    "Пол" character varying(10)
);
 *   DROP TABLE public."Покупатель";
       public         heap    postgres    false    229            �            1259    25236    поставка_id_seq    SEQUENCE     �   CREATE SEQUENCE public."поставка_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."поставка_id_seq";
       public          postgres    false            �            1259    16932    Поставка    TABLE       CREATE TABLE public."Поставка" (
    "id_поставки" integer DEFAULT nextval('public."поставка_id_seq"'::regclass) NOT NULL,
    "id_товара" integer NOT NULL,
    "Количество" integer NOT NULL,
    "Дата_поставки" date NOT NULL
);
 &   DROP TABLE public."Поставка";
       public         heap    postgres    false    230            �            1259    25230    поставщик_id_seq    SEQUENCE     �   CREATE SEQUENCE public."поставщик_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public."поставщик_id_seq";
       public          postgres    false            �            1259    16899    Поставщик    TABLE     �   CREATE TABLE public."Поставщик" (
    "id_поставщика" integer DEFAULT nextval('public."поставщик_id_seq"'::regclass) NOT NULL,
    "Название_поставщика" character varying(100) NOT NULL
);
 (   DROP TABLE public."Поставщик";
       public         heap    postgres    false    227            �            1259    25232    продавец_id_seq    SEQUENCE     �   CREATE SEQUENCE public."продавец_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public."продавец_id_seq";
       public          postgres    false            �            1259    16884    Продавец    TABLE     �   CREATE TABLE public."Продавец" (
    "id_продавца" integer DEFAULT nextval('public."продавец_id_seq"'::regclass) NOT NULL,
    "Имя" character varying(50) NOT NULL
);
 &   DROP TABLE public."Продавец";
       public         heap    postgres    false    228            �            1259    25238    продажа_id_seq    SEQUENCE     �   CREATE SEQUENCE public."продажа_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public."продажа_id_seq";
       public          postgres    false            �            1259    16942    Продажа    TABLE     @  CREATE TABLE public."Продажа" (
    "id_продажи" integer DEFAULT nextval('public."продажа_id_seq"'::regclass) NOT NULL,
    "id_товара" integer NOT NULL,
    "id_продавца" integer NOT NULL,
    "id_покупателя" integer NOT NULL,
    "Дата_продажи" date NOT NULL
);
 $   DROP TABLE public."Продажа";
       public         heap    postgres    false    231            �            1259    25240 !   производитель_id_seq    SEQUENCE     �   CREATE SEQUENCE public."производитель_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public."производитель_id_seq";
       public          postgres    false            �            1259    16894    Производитель    TABLE       CREATE TABLE public."Производитель" (
    "id_производителя" integer DEFAULT nextval('public."производитель_id_seq"'::regclass) NOT NULL,
    "Название_производителя" character varying(100) NOT NULL
);
 0   DROP TABLE public."Производитель";
       public         heap    postgres    false    232            �            1259    17038    товар_id_seq    SEQUENCE     |   CREATE SEQUENCE public."товар_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."товар_id_seq";
       public          postgres    false            �            1259    16904 
   Товар    TABLE     w  CREATE TABLE public."Товар" (
    "id_товара" integer DEFAULT nextval('public."товар_id_seq"'::regclass) NOT NULL,
    "Название" character varying(100) NOT NULL,
    "Вид" character varying(50) NOT NULL,
    "id_производителя" integer NOT NULL,
    "id_поставщика" integer NOT NULL,
    "Цена" numeric(10,2) NOT NULL
);
     DROP TABLE public."Товар";
       public         heap    postgres    false    226            �            1259    25242 8   характеристики_покупателя_id_seq    SEQUENCE     �   CREATE SEQUENCE public."характеристики_покупателя_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 Q   DROP SEQUENCE public."характеристики_покупателя_id_seq";
       public          postgres    false            �            1259    16924 1   Характеристики_покупателя    TABLE     P  CREATE TABLE public."Характеристики_покупателя" (
    "id_покупателя" integer DEFAULT nextval('public."характеристики_покупателя_id_seq"'::regclass) NOT NULL,
    "Возрастная_группа" character varying(50) NOT NULL,
    "Пол" character varying(10) NOT NULL
);
 G   DROP TABLE public."Характеристики_покупателя";
       public         heap    postgres    false    233            4          0    16967 *   Информация_о_работнике 
   TABLE DATA           �   COPY public."Информация_о_работнике" ("id_работника", "Количество_продаж", "Количество_часов", "Дата") FROM stdin;
    public          postgres    false    225   �V       0          0    16919    Покупатель 
   TABLE DATA           q   COPY public."Покупатель" ("id_покупателя", "Имя", "Возраст", "Пол") FROM stdin;
    public          postgres    false    221   �V       2          0    16932    Поставка 
   TABLE DATA           �   COPY public."Поставка" ("id_поставки", "id_товара", "Количество", "Дата_поставки") FROM stdin;
    public          postgres    false    223   "Y       .          0    16899    Поставщик 
   TABLE DATA           r   COPY public."Поставщик" ("id_поставщика", "Название_поставщика") FROM stdin;
    public          postgres    false    219   �g       ,          0    16884    Продавец 
   TABLE DATA           M   COPY public."Продавец" ("id_продавца", "Имя") FROM stdin;
    public          postgres    false    217   Ri       3          0    16942    Продажа 
   TABLE DATA           �   COPY public."Продажа" ("id_продажи", "id_товара", "id_продавца", "id_покупателя", "Дата_продажи") FROM stdin;
    public          postgres    false    224   cj       -          0    16894    Производитель 
   TABLE DATA           �   COPY public."Производитель" ("id_производителя", "Название_производителя") FROM stdin;
    public          postgres    false    218   �j       /          0    16904 
   Товар 
   TABLE DATA           �   COPY public."Товар" ("id_товара", "Название", "Вид", "id_производителя", "id_поставщика", "Цена") FROM stdin;
    public          postgres    false    220   �k       1          0    16924 1   Характеристики_покупателя 
   TABLE DATA           �   COPY public."Характеристики_покупателя" ("id_покупателя", "Возрастная_группа", "Пол") FROM stdin;
    public          postgres    false    222   ��       D           0    0 1   информация_о_работнике_id_seq    SEQUENCE SET     b   SELECT pg_catalog.setval('public."информация_о_работнике_id_seq"', 10, true);
          public          postgres    false    234            E           0    0    покупатель_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public."покупатель_id_seq"', 50, true);
          public          postgres    false    229            F           0    0    поставка_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."поставка_id_seq"', 500, true);
          public          postgres    false    230            G           0    0    поставщик_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public."поставщик_id_seq"', 23, true);
          public          postgres    false    227            H           0    0    продавец_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."продавец_id_seq"', 10, true);
          public          postgres    false    228            I           0    0    продажа_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public."продажа_id_seq"', 10, true);
          public          postgres    false    231            J           0    0 !   производитель_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public."производитель_id_seq"', 20, true);
          public          postgres    false    232            K           0    0    товар_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."товар_id_seq"', 507, true);
          public          postgres    false    226            L           0    0 8   характеристики_покупателя_id_seq    SEQUENCE SET     i   SELECT pg_catalog.setval('public."характеристики_покупателя_id_seq"', 50, true);
          public          postgres    false    233            �           2606    16972 Z   Информация_о_работнике Информация_о_работнике_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."Информация_о_работнике"
    ADD CONSTRAINT "Информация_о_работнике_pkey" PRIMARY KEY ("id_работника");
 �   ALTER TABLE ONLY public."Информация_о_работнике" DROP CONSTRAINT "Информация_о_работнике_pkey";
       public            postgres    false    225            �           2606    16923 .   Покупатель Покупатель_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."Покупатель"
    ADD CONSTRAINT "Покупатель_pkey" PRIMARY KEY ("id_покупателя");
 \   ALTER TABLE ONLY public."Покупатель" DROP CONSTRAINT "Покупатель_pkey";
       public            postgres    false    221            �           2606    16936 &   Поставка Поставка_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY public."Поставка"
    ADD CONSTRAINT "Поставка_pkey" PRIMARY KEY ("id_поставки");
 T   ALTER TABLE ONLY public."Поставка" DROP CONSTRAINT "Поставка_pkey";
       public            postgres    false    223            �           2606    16903 *   Поставщик Поставщик_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."Поставщик"
    ADD CONSTRAINT "Поставщик_pkey" PRIMARY KEY ("id_поставщика");
 X   ALTER TABLE ONLY public."Поставщик" DROP CONSTRAINT "Поставщик_pkey";
       public            postgres    false    219            �           2606    16888 &   Продавец Продавец_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY public."Продавец"
    ADD CONSTRAINT "Продавец_pkey" PRIMARY KEY ("id_продавца");
 T   ALTER TABLE ONLY public."Продавец" DROP CONSTRAINT "Продавец_pkey";
       public            postgres    false    217            �           2606    16946 "   Продажа Продажа_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public."Продажа"
    ADD CONSTRAINT "Продажа_pkey" PRIMARY KEY ("id_продажи");
 P   ALTER TABLE ONLY public."Продажа" DROP CONSTRAINT "Продажа_pkey";
       public            postgres    false    224            �           2606    16898 :   Производитель Производитель_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public."Производитель"
    ADD CONSTRAINT "Производитель_pkey" PRIMARY KEY ("id_производителя");
 h   ALTER TABLE ONLY public."Производитель" DROP CONSTRAINT "Производитель_pkey";
       public            postgres    false    218            �           2606    17027    Товар Товар_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public."Товар"
    ADD CONSTRAINT "Товар_pkey" PRIMARY KEY ("id_товара");
 H   ALTER TABLE ONLY public."Товар" DROP CONSTRAINT "Товар_pkey";
       public            postgres    false    220            �           2620    16975 N   Продажа управление_продажами_и_поставками    TRIGGER     �   CREATE TRIGGER "управление_продажами_и_поставками" AFTER INSERT ON public."Продажа" FOR EACH ROW EXECUTE FUNCTION public."управление_продажами_и_поставками"();
 k   DROP TRIGGER "управление_продажами_и_поставками" ON public."Продажа";
       public          postgres    false    235    224            �           2606    17033 6   Поставка Поставка_id_товара_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Поставка"
    ADD CONSTRAINT "Поставка_id_товара_fkey" FOREIGN KEY ("id_товара") REFERENCES public."Товар"("id_товара") ON DELETE CASCADE;
 d   ALTER TABLE ONLY public."Поставка" DROP CONSTRAINT "Поставка_id_товара_fkey";
       public          postgres    false    4748    220    223            �           2606    16957 :   Продажа Продажа_id_покупателя_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Продажа"
    ADD CONSTRAINT "Продажа_id_покупателя_fkey" FOREIGN KEY ("id_покупателя") REFERENCES public."Покупатель"("id_покупателя");
 h   ALTER TABLE ONLY public."Продажа" DROP CONSTRAINT "Продажа_id_покупателя_fkey";
       public          postgres    false    224    4750    221            �           2606    16952 6   Продажа Продажа_id_продавца_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Продажа"
    ADD CONSTRAINT "Продажа_id_продавца_fkey" FOREIGN KEY ("id_продавца") REFERENCES public."Продавец"("id_продавца");
 d   ALTER TABLE ONLY public."Продажа" DROP CONSTRAINT "Продажа_id_продавца_fkey";
       public          postgres    false    4742    224    217            �           2606    17028 2   Продажа Продажа_id_товара_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Продажа"
    ADD CONSTRAINT "Продажа_id_товара_fkey" FOREIGN KEY ("id_товара") REFERENCES public."Товар"("id_товара") ON DELETE CASCADE;
 `   ALTER TABLE ONLY public."Продажа" DROP CONSTRAINT "Продажа_id_товара_fkey";
       public          postgres    false    220    224    4748            �           2606    17006 2   Товар Товар_id_поставщика_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Товар"
    ADD CONSTRAINT "Товар_id_поставщика_fkey" FOREIGN KEY ("id_поставщика") REFERENCES public."Поставщик"("id_поставщика") ON DELETE CASCADE;
 `   ALTER TABLE ONLY public."Товар" DROP CONSTRAINT "Товар_id_поставщика_fkey";
       public          postgres    false    4746    219    220            �           2606    17011 8   Товар Товар_id_производителя_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Товар"
    ADD CONSTRAINT "Товар_id_производителя_fkey" FOREIGN KEY ("id_производителя") REFERENCES public."Производитель"("id_производителя") ON DELETE CASCADE;
 f   ALTER TABLE ONLY public."Товар" DROP CONSTRAINT "Товар_id_производителя_fkey";
       public          postgres    false    4744    220    218            �           2606    17016 p   Характеристики_покупателя Характеристики_по_id_покупателя_fkey    FK CONSTRAINT       ALTER TABLE ONLY public."Характеристики_покупателя"
    ADD CONSTRAINT "Характеристики_по_id_покупателя_fkey" FOREIGN KEY ("id_покупателя") REFERENCES public."Покупатель"("id_покупателя") ON DELETE CASCADE;
 �   ALTER TABLE ONLY public."Характеристики_покупателя" DROP CONSTRAINT "Характеристики_по_id_покупателя_fkey";
       public          postgres    false    221    222    4750            4   U   x�Uλ�0�Z��9Ɵ]��!�T�N���.���nٍm�x�X��!���ʊ%�u��j S�_��c���S�}Zk�!@      0   '  x�m�[N�@���ŠffHҽ��6��
��Y �Z���<;:�=m	�T�\~ۿ?�#~���%N�/�;Nx�;^<��y�[n)��۝l�<�q�]�!����Vo�dI�WS0A*�7^�)�%�7Aj�w�=��5y��`36��D]�kC��	����(�)
�RK��FU|mT$�+�H�5Α�L�']��3�L�s��R��K9�FIV/���1�¨U�2mPa4jtwλ8�S��Q�{g�q�ۧ�$_�]���Q*�(@]�PpF�7b6�ЇH{g r?&��zىF/��F�:����p�^#��ɑ�QQ?����o�y^�����b��X�7�x�z�w�3T���=�sr�g��W�nt��!�A>[X�TJ���pG����;́v�gdw��l��/��Lmԧ�҆��ºLoN��������*�f�S��^9��o�m��L+h�����������jౡ&$~Ӥ�~�Y��`�(�b8��^6�}��R�F�nu�g_���\�=��L?O���p�k��c�K����`0�Ό�[      2   �  x�]�[��(D��^z�3�^f��:�vF��n�Kl�l�SO�N5����_�H#����e^5���on����?i�L�����Nw���T����Z���W��Ns�~Ԙ)9i4[�JI�]i��u���,�﫴��JU�_�o;��{EA�2�F�G2~{���G�\�2���oW�ՕhW�Ic��^�Y-���zU;�_՟,�[�W��-��wI������޼�*)FZ?�J�k�:%�p?�I��i�2���9���}�s�E��}=���i�s���UW+Ic7��ui����{����7U�Q깞4�p���F�X��Oｓ��=����4�1][I�4����Fu3�O{N�4yM1k�$��]�~��ۏ�\�%������=iclsI�֨F��F�gK%s�I�k.}���L�KRh�r�W�&i5�o3�(%t�Q��0�����-i�x��i�*g�%C����+w:�ۏ|�2n����og�%�J���>N��_��4����$F0�y�5i��{Ю[��~��^e��t��F�Y+���^��/�Fپ���L+n�|Ocu�u��s�Rlx�15͕�qLͼM��(.r�fK���	z�'�㕝-U(�GY4��d�u��^s&��Tϭ����k*��_��������W��u�1
iN������Z-1�{`�����������T'I迓����9�$ܟ��2�>��6/E��z�^�����) I},r]�cF~�҆�'�l��J��y�h�/�J����� ۰z%G��}�%����lG"�$7O!����&t�E2����?�TȎ�ja����U���g]VP���z*�ei$L��:��9���,O��Y�1�u����� qs�.�v�X�.����J7�������1>2����q_Z��'�?.������*�ҍP�Ι٬��h�j���L�ɠ`^-�h��T-$`�[a&#��@B���Ha��Ӭd��	-pBR���jץ���Yi@zW��M�mF�����;0=�g��`�n6+݄;؎�Di̳阎v�0��RMX�I��%��s�'�����g��o�Y�J�`{C�o�'ڕ��H��t� '.�؉>�ԙ�j0������?ǆ�ʭ�zjj� ��r��fP�p�����ap8%�\���A�gY �=�!���o����a��$^&%_�$�O�#��Â+�,Y��A� ���6�|]2��=>f*`�G0vL�K4JXnj���qy�u�<'!3��mw �-d`�aV�݁ތ�J�nB�1-��`�S���ؘ���S�<��Lj����|� �3{��j��:�I�2!�J����	��@�۾یL<��Ϻ6+�`�#��.�C��]����>�7�K����D@ ՜�"߿����J7�B�}�8���6鶶�`�OQ�'�T�l=b*����0�tSX-�ac�ݪ���L�P�P7BO��1+���*�"S[���Ǡ�\S3���|����_e1jF�����fN��
�8R3:�C��j��k��F��^�;F�B4����4�x�>I�!/ըD��E�Z(�˯F}��Ԭ��}ЁBQ����ز�_C�&�O��E�`0	E�� �K�z`�,��
�ooA�[~����J�'t�G�k�8	�t�QZխ)[/ �Bנ���f��*��B'�u��p��#-nF	M%I�9��J�y�'b���O�8��=�j�����´/���b�W�������$��>�����턷��D6��-Ν�7��Y�|)���Cg*By��@_�/,�ՠAE�NCQ����$Zh�cyT���i��*x��*�ч���;�X���	$f����11��./���}��l'gw����-#0�f�;�AZx�D��>�@,vROo�(�B@���#�o�u�dP��<�aB�Hȩ�I�-���콕�����x��	�U���ʓ*����}Ny�R�q���*��O����9�9!�����f�%�c��j��t�<��>�V!���f���Ϭl��W�#{bIR�6@Che����ʙBXG����3;�3(nͮ��-�'jҡ !��4[�s��׷Ť�Q9�Ѓm�a��нgC/j�n���4!ԣL[���8^KqW�ȰDa(ɠ10��mu@��0�cJ^,�S^VH�0B�,͏2�-+� (�1$O�A�qJFV�@p#5	�ۋas��i��㬚�-�I+^�[hh��X�I�i�W�(@�֬*��y�i�,`�tI�[z	��2���Y��Mo���C
�~j����V,5n/��q�=z!��@s]ʝk��.��y�|:�z���vMA�~�Ư�^�PX1+�ʛ_r�DZ����EaB���c5��ɇ->^��30K�C��sM�n���t~�tFj�"Z�U������>b�3"��i
m �ٶŀ��������_H5$^}`:\�= k�7hK�=��
���ee܁�\�g�F���G�A�����t�*D�CoP;�e�$�S���E>g�\��U9Y�)SLD8Mn댶�����g9����2+̈́��E3�"�V�dR��Zdr�\=�"��7״Aٝ��v#���9uq� .��El�6�?[�#m�R�YG	9�%�@Ԧ�4d�����p#&Ո!N�N�vc�8��i��x[��ܸ6�c�G����A ��H ��d�P�k�����PiBݒ{��xy7�ч�4QC8xIF�D��c:ܤ�r>!}r%T�O��p�����)De8R��$&}:osY�M�@�j��Jz#9�,:�p?�T"" ta���V�nK�Q
�zB�s���C@�R����0�߂}�sA�S�y������锬yz3?��S�V
1�I)B�'%����e�����b!`;{�n��-ry+��8����m��Q�!�v��
�l���x��fB���6w�o�~	~��|��'�u�c���S�w�C7�f�s���XW�0Z<�.bp��X44�|�g�;Ћ�Y:���=�[�w�c�_[<-�^����U8w��SҲ�k�'�~��ҭ4/�~�J7��p�b!���<*��{F2�n���	�G���C�ښ�fe{_��)	)}EB@��U��?��]�giV���^w�'�_X�v�H��Z1��!!�g�w.�� t�u�Ď'�q��/<�{�-�o)��A���TQy�7.���/��z�� ��_��n ���:���ۤpڂ�
�y��I��;����Cл����nC:DD���"�:��X����qw5nLr��<<�j]��]L�y���]ո:
>��w�N�����c{×Bl�K_���&\�iY���|M2(Ԋ_9<�����Ğ���o�(C�+2����]��.o���׸��"��B�g����R�sq3NZ{bw��;{};L,��u��tk�8������0�~�_�>��|�p��Ȯ���U�UR��?ުPV0�0|C؁e��h�;�ƀ�0���ˆ�0'����G�g�fr���]��Ú G^��1����%/_r�q3��9!�ʤe�`��좙�=�XC�/�1��Q����:���tl4@V�Q�3�.�N�h&���D�j�g��.����m�Z^!�5g�a|�����Cz��]���C�����R���V�4���_���fw��͚r]�l/28�?����|��Ml4@��67ס��Oϱ���]9~[!����������      .   ^  x�mR[N�P��g]����b�cLMF���/�Z[R@����9�V���>�;3gfzz+��F�M�9r{�;4�7X�5�%��W�||��Ħ�6re� ���I�l�-��^�ci3�H�,�����I�eh�N^�N���\���k�7���Aw�M�1�J��f)��3������44x���j-�0��0��vnmb���և*�>�	��br	��$Ku
_�Q���JBV6u5�h�.\���O%��'������iп������|�:gK�~n���u�P�p�'u.4�v",�$�Ǒq˔r~��
gmju�&�e�U�j��^�̦�@�~	����s�i      ,     x�eQ[n�@��=Ş J[���A��H DUT�V�Ɋ��0{#�&
�G��=�>�"G�SㄝkS���<�l�����B��G~�H�+e��Y#h�6�M���J���J�EAA�$�=�
�CĿ6'�_�g%�ʜ_dO %�_fm�*
q��&eRƶl�J�+L�ב�j�����V*�$m����j���j$���q���C��q^�~��Ú���}u��!�Ӻ>U��kT�=���7m�W�Gk��5Z4      3   H   x�M���0Cѳ�KP�6)ð��O~��������XmJ�(�g�s�m��@�O�ˢ�D�=O��:H޳�@      -     x�]��n�0E�㯘/@�G�۶<V�DE7݌X24�P��됤���¾�s]�F�#�(npMzMn[�;'�7�RYrSX+�
�Fj�9'7�Y���E�h����a���Ľ�i�=�F�9�l�|LYv�Ql�ٍC�A�\��],�I�>U�Z.���b���c���h�����V�G%��\��[�b�:��~h1�U)�"k��&J�%�b[�`U���k�p�~��.9o�[�;��z�&=�Kx�d��5��8�m�c��;����ėG���9�#���      /      x��\[��q���
l�U��܋�h�� #hY?-˲"��/� a l�gG�s�/�Gwu�\�CW��잪ʬ̓Y��������ί��������/��N�J�S����y�>�ا�2��B�# ��'p�����W���iԻ���J���5������߆���h����������Ww�>��T�����e�h���I�8��`c���>%�װ�����n������D�O�7����������_~??��"���B�ܨE�m�Ӣ7jI��Z��LK�QKƷ�2�jZ�Z
�]�d+���T|���a\�Z��ǩg��n����5L����i��o�)ګ�p��G�p�6[��>�~i�����w��/iր���i�N����-� ��l�4�EA�G���t��l���$��Z�E���h���[���ا�p�����[�E|$jP��o�����>���TЛ6͓��(��l)ol�y2r�����5t9&D_�z�5w=&Dט�N���	�'�}5���|L���h���F/Ǆ�碍^5���1!�5I�̄z;&D/f���r��b�J��!{�}�E�f��o��,B+*yg߆��а���·�/��&��|`����M�S���0�
�6 �>�b�7�3����@т��*�bf1���	_\��>�q��T�V��&�K�ؤY�dm�ʓ�xn��qa�j�"_�M��يq�?6a\��2B�k�m�m.��-���lvWma�m}��Ԧ�.b^�_��r�}��6�T�x3|�MV�dN�Et��]2�_�&��1M��7A\�k�p���ª�I�K�n���E3�\�m���s���o��$Ȕ�E�6�cnXs$��g����kNԛ��lg,rQC}KI���fa��yMc,M&lcib�nٕ�1�&���䴎���������X�J3��6f}�u{��]4���'��X���/�������f�͸Đ2D�t�MB��Q�H�O�}��_�!��9�b:�	;���a_/C$S۔�^S"ș�D�C$m�l�!�"ݮĞo�������^2�gn��Z��R��F�BѠ�9��.Y�P4�f���:9m�hD�|�-���P6�k����ݴf��!uE���w*��m�h+"	��ʭDb�B����{��/�$�Ծ��?�U4(��"�[���p0��|�4��.�r5�hK�`�6Z<�p���z���K��m�AK�t�>�-O��.5�������årJ�3�{f��v�$���2B�&zH��#$���{��R�Iې�&�K�#$��h���FR� ,�u���4	X�����5��n{@���I�F:��XB&��b�%bx����iM���$�+1�n�`-Ѷ��/�6P0��*\8�L�u歭l��y؆���������m1�m�`$bM�K�(7��:&��m���r�$�ߚ=���iTe�]�p��{L邬z�5�K���y�[�+zY���F0�.��c<X^o됅��H�z_�,�Q��$c늰~����%�\���������ţ�������������B���RA�Jc�7�����4Am�lYƐ�J�@�y�\6��fc��"D[��I���چ_X�>�;TEC=+{Ts����4�F�ҡ�^v8����N�;gv�m�0��� ������i ��6�Ii�%,�KѤ��4�yԊ�N
�ŐK���Ii'6,��X��4ݒ���XO
;	�#�NJ�+�x��9iwr5�>�N>��h=
+���g�����_֊*H9/X�vPez^�Ie%%��gH],�����Y�������pp��9u��<|\�p��������)�����Kbk��&P�
<�p.�J�����Om;yr���Q��^:)Ng��E��@9����S�e,�Iq������i��:�PB�`�N�/oC��`��_JL�#X����|�+�^L�9��,NdR#诓�Gm�|�%	��ٺ}a�m����@�.X�s���6`��I{�%�
�����׫��V������+���g�u;'͐.z� L�9i����Ow;+oKd������l�,6g`�N���e{>"�̨�����Mr�W��W7�>�Wm&�<\����O��!���wD�o���D[�j�"�+��h�����:��ƕ���ŖP���p����G�o1�+�o����Jx��!��4�B��#���H܏���1�/rVn����E�J��-��tVn��:���J��J�n����p�E,5�*��4{�ދ����[F;#x�g���23�N��+��ss���..�m��p
�!l�4��fK�+V�A�BU+���n�@�j1��oа4(��Zn��98ꩶk�A�S�,6��nP@��m�GD\�yK>�������ϦAN{��QĐ&�*��r��D�b�����X�E�Ϝ}��#��h����	}�Ж�N� zVZy�:xY�������vs��ڃձ�m��1���ǜ;����hT��2:-Q���7�����TiB�i��94:�`^d^�ϡr!�f��s��b~c������t�"F�|�J������P�|ڜa�A��{MmJ�"!|���O�,̼�r��|b"�sV�ò�ej��$�
��Zс"A�PgU[3CB�	TM�C(�,���Yee4�,�ϪC(C�DIBBYz-,.H�C�R�1h�/c�a�/Y�+����&�K�\��$�DP�Y�y�����QY�y�%ETZ�a��&�܂��:̉DM�Ղ��:�&�m���	uF3C'��u���p��C�c�T�-�CQ�X�f�Z�((e�;�鑙�3�/Q87k{���$4��Ƞx�/A�.	�NQ�ؗ�)�ţbÊž-�4���H��C)�xE�}	�W$�-(;�K�̊��+(4�K0�KL���}���l;q�!ڞJE�.��{�1��ן�_�͊�2�z�F��Tu��Z�p_4���b�SQ��<�z�b-#�r�������^���muӌ��T��K�jfy)����.�79�������鞖��MK�-�ED�@_���$��y"g�Wa��D�8%�
c>��[ل�A�m�I�U;:�]q2{E�:�@&�Z���z�wBg��q��fp�����G �J4STh�u��-��$Y�A�qV@rZ�	���9�������KrYy�h�|����%@�MPn� ?��2	ީ����OgH	�Xcw-ϙ;{z}N��h�2��"�}�5�H��� 	�%6-i dIȼuģ� x�[�~�x�G�
}�&� ���l
��o }GdA⧈7�n
1����[P�KR�i�,ʼ�x�%��A�M����2��9��¾TA��hˣ�ԫ�1r��y]�L��R��1��~�QjA�nB�:~VA�-�8��ХK/2ϓFZq`���E���ի
��o?	�rAC���ڀ�ݴ�' �6P0!4XV[J �6`�7�݈�i��D4����y�D��P���@0&>"��@�l���?�R`�a�����Vt�<r���4��6��=��S��1��[0Ox���Uzڂ-�=#�P�0'���V�`~�ӂ���P�`4�h^$���sr��-�o���
��;Na�-mHx,�2��@cxm���\�~s}<�}4�|����w&I8��م3�
d�݅s�Q��5�]8O������.�V���Pv��yBF������匮AmΖ)�������Ш�ט/þ�W�(�(؄?a��\�!�y.W��^aO�)J�,TT0{~�:�j�1װ'�uz�1+X�=g�<1Je_�KEU�"LĞ�'?��"ھ��`��h�Ď�b��5�7���{�}zf��`,��.+D����d��E ��0L�_�`��lL ��ov<�� &�`X�
9?'1����:b���M�
&b^6��;*H�1����X�{�v~7�UA����������ܹ��#��i�V��jރ����*ղ��vN�u픡�����4�*��j߁/��y�����GB��.�^�`�
E�כ�O*>�qd9(tOʫ� 1	��Gn8s�� �  4	�p�������M�^9(D�0�W����F��B	�����b���!�eC���
��=
��jv�
gw�ϖwp���(�`�cBކא�i�c2n���qiNǄ�6`���T�|L�3��֑�1!߭�j��d��o�=��1!ߴY����,��V{�p�A�6�
N�d;�AYb�$��x�sH�/��I"�sH�e�����!!��9=���	���Q���rn��L<���ʌ�
��["��+(�CB}d�Y7g	�蘘lh征�����c�PmI��W9"��r�����?�/���H,�`3a���B�Y�g�o��Z���SȞh�vD��]-Q�k����}G�{��<5{��qiHcΆ�^̯�=[M!"�D��KS�!}e18�GK�D���i4m�����ʵ�C"<�;�8i���G��Ihk�DX<�HO��!��iP�O�pLh	x�Z�4��E,,\�	�wyh�s�?_9��u���΢F���9Y'�"F��s��F���s���!���zN؏�����j�=��ʋ�~Jx9�d�ޢ�¹'#%R�	d߿�ch~��'P��������E��3���W���=��ۗ �JH5	="�0��?#�`wC��G�YĲq>�� w�	��@��K�����vD�����$��/^��< �E6���������?����^P��S�]�S��:)�]�ߊRG��w����{)�]<� 
=�{4�]�s�Cw)�]�����ƾ��]1/aW=�!
h�$$�x��?��?5��:����(K`��D����S�ޓ$���S������Qi�.	�S���N,5&��x��8{������{���>����M��ޯ�ٰ��|�W�٭�D`��\�U.~9br>p�{)H,�3����j���rpH�L�A�ٿu�;�����:p9�F�79�\�G�\N�������1N�kd�-�������������d�m���~(���F;� �d{��v)�L�q�b� ��p�1~L ��6�cJu �%�Rj M[���KF��=p�_Ai4f�t��p/ؓ뗣ˇ����e_�ۖ�!s�m,����'�cwrm,�����7&'��[��jc�嶒��.9�6�
�ǞN����Ma��$g҆�א�589�6~l0s��)jpW�7F�� yc� LN=����r��?c7�g      1   �   x�u��1Eѵ�

���B3�X�����#��{[ˊ�����Z�q����s�ǣ�XV_Ǘ�i�~��:v��nҲ�f����b�;>���:Idm�uU,QCul��mD�D3M���|ń5�Xc�5�Xc�4�k�hf��D�`�OH�5�:%�z`���&�a';�8H�A*Xq���T�� �8`�A*n��þ��t�?     